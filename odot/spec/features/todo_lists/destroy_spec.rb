require 'spec_helper'

describe "Deleting todo lists" do
	it "destroys an item from the todo list" do
		todo_list = TodoList.create(title: "Supplies", description: "Get some supplies.")

		visit "/todo_lists"
			within "#todo_list_#{todo_list.id}" do
				click_link "Destroy"
			end

	

		expect(page).to_not have_content(todo_list.title)
		expect(TodoList.count).to eq(0)
	end
end