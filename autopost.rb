require 'rubygems'
require 'mechanize'
require 'rufus/scheduler'

def posttowebsite(username, password, title, text)
	session = Mechanize.new
    session.user_agent_alias = 'Mac Safari'
	form = session.get('http://www.nachhilf.ch').form_with(:action => '/users/login?class=text')
    params = {'username' => username, 'password' => password}
    params["authenticity_token"] = form["authenticity_token"]
	session.post('http://www.nachhilf.ch/users/login?class=text', params)
	session.get('http://www.nachhilf.ch/users/5436').body
    params2 = {'class' => 'new_subscription','id' => 'new_subscription', 'authenticity_token' => params["authenticity_token"], 'subscription[topic_id]' => '17', 'subscription[search_find]' => '0', 'subscription[title]' => title, 'subscription[description]' => text, 'commit' => 'Inserat speichern'}
    session.post('http://www.nachhilf.ch/subscriptions', params2)
end


scheduler = Rufus::Scheduler.start_new

scheduler.cron '*/1 * * * *' do
    puts 'Post'
    posttowebsite('learningculture','Super-Hans2013','test','test')
end

scheduler.join

# try scheudling
# upload to git
# upload to heroku and try :)

