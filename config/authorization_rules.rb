authorization do
  role :admin do
  	has_permission_on [:users], :to => [:index,:show, :new, :create, :edit, :update, :destroy,:logout, :user_update, :edit_user, :admin_list, :doctor_list, :department, :create_department, :delete_department, :assign_department, :department_doctor, :appointment_status, :department_wise_appointment, :genrate_csv, :institutions, :uploads]
  end
  role :guest do
  	has_permission_on [:users], :to=>[:signin,:index,:login, :update, :edit_user]
  end
  role :doctor do
  	has_permission_on [:doctors], :to=>[:new,:find_appointment, :create, :appointment_csv]
  end
  role :patient do
  	has_permission_on [:patients], :to=>[:new, :update_department, :book_appointment, :appointment_cancel, :destroy, :prescription_list, :prescription_view]
  end
end