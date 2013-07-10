require 'sinatra'

set :port, 3000
set :public_folder, File.dirname(__FILE__) + '/public'

SIGNS = ['rock', 'scissors', 'paper']

get '/' do
  erb :index, locals: { signs: SIGNS }
end

post '/throw' do
  user = params[:sign]
  server = SIGNS.sample
  erb :result, locals: { user: user, server: server, message: message_for(result(user, server)) }
end

# Rock beats scissors
# Scissors beats paper
# Paper beats rock
# Identical throws tie (rock == rock, etc.)
def result(user, server)
  raise "Unknown user input: #{user}" if !SIGNS.include?(user)
  return 0 if user == server

  case user
  when 'rock'
    server == 'scissors' ? 1 : -1
  when 'scissors'
    server == 'paper' ? 1 : -1
  when 'paper'
    server == 'rock' ? 1 : -1
  end
end

def message_for(result)
  case result
  when 1
    'You win!'
  when -1
    'You lose!'
  when 0
    'Tie!'
  else
    ''
  end
end
