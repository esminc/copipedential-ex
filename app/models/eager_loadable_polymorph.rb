module EagerLoadablePolymorph
  class ConditionBuilder
    def initialize(association)
      raise ArgumentError, "#{association} is not polymorphic association" unless association.options[:polymorphic]
      @association = association
    end

    def condition_to(type, klass = nil)
      klass ||= type.to_s.classify.constantize
      {
        foreign_key: fk,
        conditions: ["EXISTS(SELECT 1 FROM #{tbl} WHERE #{tbl}.#{ft} = ? AND #{tbl}.#{fk} = #{klass.quoted_table_name}.#{klass.primary_key})", klass.name]
      }
    end

    def override_accessor(to)
      assoc_name = @association.name
      type_col = ft

      to.class_eval <<-RUBY.strip_heredoc
        def #{assoc_name}
          concreate_item = association(self[#{ft.dump}].underscore.to_sym)
          polymorphic_item = association(:#{assoc_name})
          if concreate_item.loaded? && !polymorphic_item.loaded?
            polymorphic_item.target = concreate_item.target
          end
          super
        end
      RUBY
    end

    private

    # aliasses
    def ft
      @association.foreign_type
    end

    def fk
      @association.foreign_key
    end

    def tbl
      @association.active_record.quoted_table_name
    end
  end

  def eager_loadable_polymorphic_association(association_name, types)
    cond = ConditionBuilder.new(reflections[association_name.to_sym])

    types.each {|t| belongs_to t, cond.condition_to(t).merge(readonly: true) }

    scope "with_#{association_name}", includes(*types)
    cond.override_accessor(self)
  end
end


