class Department < ActiveRecord::Base
	 has_many :doctors, :dependent=> :destroy
end
