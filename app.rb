require("bundler/setup")
Bundler.require(:default, :production)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get('/') do
    @members = Person.all()
    erb(:index)
end

post('/') do
    name = params.fetch('name')
    Person.create(:name => name)
    redirect('/')
end

get('/members/:id') do
    @person = Person.find(params.fetch("id"))
    @members = []
    people = Person.all
    people.each do |person|
    if (person != @person) &&  @person.parents_kids.include?(person) == false &&  @person.kids_parents.include?(person) == false
    @members.push(person)
    end
    end
    erb(:person)
end

post('/members/:id/add_parent') do
    @id = params.fetch("id")
    # if params.fetch("parent_id") != nil
    @person = Person.find(@id)
    parent = Person.find(params.fetch("parent_id"))
    @person.kids_parents.push(parent)
    # end
    redirect("/members/#{@id}")
end

post('/members/:id/add_child') do
    @id = params.fetch("id")
    @person = Person.find(@id)
    child = Person.find(params.fetch("child_id"))
    @person.parents_kids.push(child)
    redirect("/members/#{@id}")
end

patch('/members/:id/create_parent') do
    @id = params.fetch("id")
    # if params.fetch("new_parent") != ""
    @person = Person.find(@id)
    parent = Person.create(:name => params.fetch("new_parent"))
    @person.kids_parents.push(parent)
    # end
    redirect("/members/#{@id}")
end

patch('/members/:id/create_child') do
    @id = params.fetch("id")
    # if params.fetch("new_child") != ""
    @person = Person.find(@id)
    child = Person.create(:name => params.fetch("new_child"))
    @person.parents_kids.push(child)
    # end
    redirect("/members/#{@id}")
end

get('/deleted') do
    Person.clear_all
    redirect('/')
end
