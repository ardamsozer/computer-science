# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
requests_seed = [{user_tarjimly_id: 1, from_language: 'English', to_language: 'Arabic', document: 'location_of_file', document_format: 'pdf', deadline: '25-Nov-2019',
                  title: 'Camp Announcment', description: 'Event going on in camp', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 1, from_language: 'English', to_language: 'Urdu', document: 'location_of_file', document_format: 'pdf', deadline: '25-Nov-2019',
                  title: 'Camp Announcment', description: 'Event going on in camp', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 2, from_language: 'Arabic', to_language: 'Urdu', document: 'location_of_file', document_format: 'jpg', deadline: '25-Dec-2019',
                  title: 'Visa Application', description: 'Information for steps in visa application', categories: 'MISSING', num_claims: 0, form_type: 'Visa Application', _status: 0},
                 
                  {user_tarjimly_id: 2, from_language: 'Urdu', to_language: 'English', document: 'location_of_file', document_format: 'png', deadline: '15-Nov-2019',
                  title: 'Governement Forms', description: 'Governemnt forms regarding family dependencies', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 4, from_language: 'English', to_language: 'Arabic', document: 'location_of_file', document_format: 'pdf', deadline: '01-Jan-2020',
                  title: 'Doctor Notes', description: 'Notes from recent Doctors visit', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 5, from_language: 'English', to_language: 'Arabic', document: 'location_of_file', document_format: 'pdf', deadline: '25-Dec-2019',
                  title: 'Lawyer Meeting', description: 'Times to schedulue upcoming appointment', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 1, from_language: 'English', to_language: 'Arabic', document: 'location_of_file', document_format: 'pdf', deadline: '25-Nov-2019',
                    title: 'Camp Event', description: 'Event going on in camp', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 1, from_language: 'English', to_language: 'Urdu', document: 'location_of_file', document_format: 'pdf', deadline: '25-Nov-2019',
                    title: 'Doctor Appointment', description: 'Event going on in camp', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 2, from_language: 'Arabic', to_language: 'Urdu', document: 'location_of_file', document_format: 'jpg', deadline: '25-Dec-2019',
                    title: 'Visa Request', description: 'Information for steps in visa application', categories: 'MISSING', num_claims: 0, form_type: 'Visa Application', _status: 0},
                 
                  {user_tarjimly_id: 2, from_language: 'Urdu', to_language: 'English', document: 'location_of_file', document_format: 'png', deadline: '15-Nov-2019',
                    title: 'Passport Forms', description: 'Governemnt forms regarding family dependencies', categories: 'MISSING', num_claims: 0, form_type: 'Passport Application', _status: 0},
                 
                  {user_tarjimly_id: 4, from_language: 'English', to_language: 'Arabic', document: 'location_of_file', document_format: 'pdf', deadline: '01-Jan-2020',
                    title: 'Marriage License', description: 'Notes from recent Doctors visit', categories: 'MISSING', num_claims: 0, form_type: 'Marriage License', _status: 0},
                 
                  {user_tarjimly_id: 5, from_language: 'English', to_language: 'Arabic', document: 'location_of_file', document_format: 'pdf', deadline: '25-Dec-2019',
                    title: 'University Diploma', description: 'Times to schedulue upcoming appointment', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 1, from_language: 'English', to_language: 'Arabic', document: 'location_of_file', document_format: 'pdf', deadline: '25-Nov-2019',
                      title: 'University Application', description: 'Event going on in camp', categories: 'MISSING', num_claims: 0, form_type: 'University Application', _status: 0},
                 
                  {user_tarjimly_id: 1, from_language: 'English', to_language: 'Urdu', document: 'location_of_file', document_format: 'pdf', deadline: '25-Nov-2019',
                      title: 'Doctor Meeting Confirmation', description: 'Event going on in camp', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 2, from_language: 'Arabic', to_language: 'Urdu', document: 'location_of_file', document_format: 'jpg', deadline: '25-Dec-2019',
                      title: 'School Enrollment', description: 'Information for steps in visa application', categories: 'MISSING', num_claims: 0, form_type: 'School Enrollment', _status: 0},
                 
                  {user_tarjimly_id: 3, from_language: 'Urdu', to_language: 'English', document: 'location_of_file', document_format: 'png', deadline: '15-Nov-2019',
                      title: 'Governement Notice', description: 'Governemnt forms regarding family dependencies', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 4, from_language: 'English', to_language: 'Arabic', document: 'location_of_file', document_format: 'pdf', deadline: '01-Jan-2020',
                      title: 'Medical Note', description: 'Notes from recent Doctors visit', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0},
                 
                  {user_tarjimly_id: 5, from_language: 'English', to_language: 'Arabic', document: 'location_of_file', document_format: 'pdf', deadline: '25-Dec-2019',
                      title: 'Lawyer Meeting', description: 'Times to schedulue upcoming appointment', categories: 'MISSING', num_claims: 0, form_type: 'N/A', _status: 0}
]

claims_seed = [{translator_tarjimly_id: 1, _status: 0, submitted_date: 'N/A', translation: 'location_of_file', translation_type: 'pdf', request_id: 1},
               {translator_tarjimly_id: 1, _status: 0, submitted_date: '6-Nov-2019', translation: 'location_of_file', translation_type: 'text-box'},
               {translator_tarjimly_id: 1, _status: 1, submitted_date: 'N/A', translation: 'location_of_file', translation_type: 'pdf', request_id: 2},
               {translator_tarjimly_id: 1, _status: 2, submitted_date: 'N/A', translation: 'location_of_file', translation_type: 'jpg', request_id: 3},
               {translator_tarjimly_id: 1, _status: 0, submitted_date: 'N/A', translation: 'location_of_file', translation_type: 'pdf', request_id: 4}
]


requests_seed.each do |r|
  Request.create(r)
end

claims_seed.each do |c|
  Claim.create(c)
end