# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

#populate test data - remove for production

deliveries = Delivery.create([{:delivery_date => Date.today, :comment => 'Day one...', :recipient_id => 1},
                                      {:delivery_date => Date.today + 1, :comment => 'Day two...', :recipient_id => 2},
                                      {:delivery_date => Date.today + 1, :comment => 'Day two...', :recipient_id => 3},
                                      {:delivery_date => Date.today + 2, :comment => 'Day three...', :recipient_id => 4},
                                      {:delivery_date => Date.today + 4, :comment => 'Day five...', :recipient_id => 5}
                                      ])
                                      
recipients = Recipient.create([{:first_name => 'Robin', :last_name => 'Holmes', :phone_number => '5191234567', :notes => 'First recipient...'},                                     
                                      {:first_name => 'Trevor', :last_name => 'Fuddle', :phone_number => '5191234567', :notes => 'Second recipient...'},
                                      {:first_name => 'Abel', :last_name => 'Jackson', :phone_number => '5191234567', :notes => 'Third recipient...'},
                                      {:first_name => 'Kim', :last_name => 'Hubuert', :phone_number => '5191234567', :notes => 'Fourth recipient...'},
                                      {:first_name => 'Steve', :last_name => 'Keel', :phone_number => '5191234567', :notes => 'Fifth recipient...'},
                                      {:first_name => 'Johnny', :last_name => 'Hoisen', :phone_number => '5191234567', :notes => 'Sixth recipient...'},
                                      {:first_name => 'Farouk', :last_name => 'Hazen', :phone_number => '5191234567', :notes => 'Seventh recipient...'},
                                      {:first_name => 'Kibble', :last_name => 'Nuts', :phone_number => '5191234567', :notes => 'Eighth recipient...'}
                                      ]) 
                                      
vincentians = Vincentian.create([{:first_name => 'Elsi', :last_name => 'Hallahan', :phone_number => '5191234567'},
                                            {:first_name => 'David', :last_name => 'Hallahan', :phone_number => '5191234567'},
                                            {:first_name => 'Patrick', :last_name => 'Hallahan', :phone_number => '5191234567'},
                                            {:first_name => 'Kerry', :last_name => 'Brode', :phone_number => '5191234567'},
                                            {:first_name => 'Julie', :last_name => 'Lawrence', :phone_number => '5191234567'},
                                            {:first_name => 'Peter', :last_name => 'Wilson', :phone_number => '5191234567'},
                                            {:first_name => 'Steve', :last_name => 'Jones', :phone_number => '5191234567'}
                                            ])                                      
                                      
teams = Team.create ([{:vincentian_id => 1, :delivery_id => 1, :pairing => 1},
                                {:vincentian_id => 3, :delivery_id => 1, :pairing => 1},
                                {:vincentian_id => 2, :delivery_id => 2, :pairing => 2},
                                {:vincentian_id => 4, :delivery_id => 3, :pairing => 3},
                                {:vincentian_id => 5, :delivery_id => 3, :pairing => 3},
                                {:vincentian_id => 6, :delivery_id => 4, :pairing => 4}
                                ])         







