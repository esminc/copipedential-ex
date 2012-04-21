module EagerLoadablePolymorph
  class AssociationWriter
    def initialize(association, types)
      raise ArgumentError, "#{association} is not polymorphic association" unless association.options[:polymorphic]
      @association = association
      @types = types
    end

    def belong_to_them(ref_from)
      @types.each do |t|
        ref_from.belongs_to t, readonly: true, foreign_key: fk, conditions: condition_sql(t.to_s.classify.constantize)
      end
    end

    def define_scope(ref_from)
      ref_from.scope "with_#{@association.name}", ref_from.includes(*@types)
    end

    def override_accessor(ref_from)
      ref_from.class_eval <<-RUBY.strip_heredoc
        def #{@association.name}
          concreate_item = association(self[#{ft.dump}].underscore.to_sym)
          polymorphic_item = association(:#{@association.name})
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

    def condition_sql(klass)
      ["EXISTS(SELECT 1 FROM #{tbl} WHERE #{tbl}.#{ft} = ? AND #{tbl}.#{fk} = #{klass.quoted_table_name}.#{klass.primary_key})", klass.name]
    end
  end

  def eager_loadable_polymorphic_association(association_name, types)
    assoc = AssociationWriter.new(reflections[association_name.to_sym], types)

    assoc.belong_to_them(self)
    assoc.define_scope(self)
    assoc.override_accessor(self)
  end
end

