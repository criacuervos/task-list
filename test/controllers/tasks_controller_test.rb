require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completed: Time.now + 5.days
  }

  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      # Act
      get tasks_path

      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid task" do
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do

      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do

      # Arrange
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completed: nil,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed).must_equal nil
      #Need to change to 'assert_nil' but having trouble finding correct syntax and documentation for this

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing task" do
      skip
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      skip
    end
  end

  describe "update" do
    before do 
      Task.create(name:"Chores", description:"Mop the floor")

      @new_task_hash = {
        task: {
        name: "Homework",
        description: "Complete personal portfolio",
        completed: 10/6/19,
        },
    }
    end 

    it "can update an existing task successfully and redirects to home" do
      existing_task = Task.first 
      id = existing_task.id


      expect {
        patch task_path(id), params: @new_task_hash 
      }.wont_change "Task.count"

      expect(Task.find_by(id: existing_task.id).description).must_equal "Complete personal portfolio"

      must_redirect_to task_path(existing_task.id)

    end

    it "will redirect to the root page if given an invalid id" do
      invalid_id = -1
      expect
    end 

    it "will respond with not_found for invalid ids" do 
     id = -1

     expect {
       patch task_path(id), params: @new_task_hash
     }.wont_change "Task.count"

     must_respond_with :error
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here

  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
