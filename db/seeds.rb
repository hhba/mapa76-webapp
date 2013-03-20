# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_1     = FactoryGirl.create :user, email: "johndoe@gmail.com"
project_1  = FactoryGirl.create :project, name: "ESMA"
document_1 = FactoryGirl.create :document, title: "Veredicto ESMA", user: user_1, public: false
document_2 = FactoryGirl.create :document, title: "Alegato ESMA", user: user_1, public: false
document_3 = FactoryGirl.create :document, title: "Nunca Mas", public: true
document_4 = FactoryGirl.create :document, title: "Nota de Pagina 12", user: user_1, public: true

user_1.projects << project_1
project_1.documents << document_1
project_1.documents << document_2
