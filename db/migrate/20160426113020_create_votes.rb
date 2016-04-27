class CreateVotes < ActiveRecord::Migration
  def up
    create_table :votes do |t|
      t.string "campaign_name"
      t.string "candidate_name"
      t.string "validity"
      t.string "guid"
      t.timestamps null: false
    end
  end
  def down
    drop_table :votes
  end
end
