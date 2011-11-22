Fabricator(:user) do
  nickname { sequence(:nickname) {|i| "alice\##{i}" } }
  uid { sequence(:uid, 1001) }
  provider 'test'
end
