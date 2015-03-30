json.array!(@users) do |user|
  json.extract! user, :id, :email, :username, :first_name, :middle_name, :last_name, :phone, :zipcode, :facebookid, :githubid, :googleid, :linkedinid, :twitterid, :picurl, :superuser
  json.url user_url(user, format: :json)
end
