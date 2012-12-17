ActiveAdmin.register DevProfile do
  index do
    selectable_column
    column :user
    column :hourly_rate
    column :ext_hourly_rate
    column :gsm
    default_actions
  end

end
