Fabricator(:picture) do
  name { sequence(:picture_name) {|i| "Picture \##{i}" } }
  raw_data { (Rails.root + 'app/assets/images/rails.png').read }
end
