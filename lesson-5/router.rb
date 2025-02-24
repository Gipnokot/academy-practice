# frozen_string_literal: true

module Resource
  # The connection method handles requests to resources
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      if routes[verb].nil?
        puts 'Choose correct verb: (GET/POST/PUT/DELETE)'
        next
      end

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end

      if action && action.empty?
        puts "Please choose 'index' or 'show'!"
        next
      end

      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

# the postscontroller class manages posts
class PostsController
  extend Resource

  def initialize
    @posts = ['Hello', 'Hello(again)']
  end

  def index
    if @posts.empty?
      puts 'No posts available.'
    else
      @posts.each_with_index do |post, index|
        puts "#{index}. #{post}"
      end
    end
  end

  def show
    print 'Enter post id: '
    id = gets.chomp.to_i
    if id.negative? || id >= @posts.size
      puts "Post with id #{id} does not exist."
    else
      puts "#{id}. #{@posts[id]}"
    end
  end

  def create
    print 'Enter post content: '
    content = gets.chomp
    if content.empty?
      puts 'Post content cannot be empty!'
    else
      @posts << content
      puts "Post created with id #{@posts.length - 1}. #{content}"
    end
  end

  def update
    print 'Enter post id: '
    id = gets.chomp.to_i
    if id.negative? || id >= @posts.size
      puts "Post with id #{id} does not exist."
    else
      print 'Enter new post content: '
      content = gets.chomp
      if content.empty?
        puts 'Post content cannot be empty!'
      else
        @posts[id] = content
        puts "Post updated: #{id}. #{content}"
      end
    end
  end

  def destroy
    print 'Enter post id: '
    id = gets.chomp.to_i
    if id.negative? || id >= @posts.size
      puts "Post with id #{id} does not exist."
    else
      @posts.delete_at(id)
      puts 'Post deleted.'
    end
  end
end

# the router class is responsible for routing requests
class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
