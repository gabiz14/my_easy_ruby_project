require 'spec_helper'
describe "Creating todo lists" do
	def create_todo_lists(options={})
		options[:title] ||= "My Todo List"
		options[:description] ||= "Buy some food"

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end
	it "redirects to the todo list index page on sucess" do
		create_todo_lists
		expect(page).to have_content("Todo list was successfully created.")
	end

	it "displays an error when tod list has no ttile" do
		expect(TodoList.count).to eq(0)

		create_todo_lists title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("what i am doing.")

	end

	it "displays an error when todo list has no description" do
		expect(TodoList.count). to eq(0)

		create_todo_lists description: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("New item")
	end

	it "displays an error when todo list has a ttile less than 3 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_lists title: "hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("what i am doing.")

	end

	it "displays an error when todo list has a description of more than 100 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_lists description: "qwertyuiopqwertyuiopqwertyuiopqwertyuiopqwertyuiopqwertyuiopqwertyuiopqwertyuiopqwertyuiopqwertyuiopqwertyuiop"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("what i am doing.")

	end

end