module UsersHelper

 def profile_image(user)
 	if user.avatar_path.present?
 		avatar = user.avatar_path
 	else
   	   avatar = "/images/avatar.png"
   	end
   	return avatar
 end

end
