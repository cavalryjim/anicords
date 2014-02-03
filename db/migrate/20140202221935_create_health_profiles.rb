class CreateHealthProfiles < ActiveRecord::Migration
  def change
    create_table :health_profiles do |t|
      t.integer     :animal_id
      t.date        :last_exam_date
      t.string      :last_exam_location
      t.date        :heartworm_test_date
      t.string      :heartworm_test_location
      t.boolean     :heartworm_test_result
      t.date        :fiv_felv_test_date
      t.string      :fiv_felv_test_location
      t.boolean     :fiv_felv_test_result
      t.timestamps
    end
  end
end
