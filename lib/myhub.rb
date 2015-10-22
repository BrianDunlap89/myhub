require "sinatra/base"
require "httparty"
require "json"
require "pry"

require "myhub/version"
require "myhub/github"

module Myhub
  class App < Sinatra::Base
    set :logging, true

    get "/" do
      api = Github.new
      issues = api.list_issues
      @issue_data = []
      issues.each do |issue|
        issue = { 
                  title: issue["title"], 
                  url: issue["url"],
                  number: issue["number"],
                  state: issue["state"],
                  created: issue["created_at"],
                  updated: issue["updated_at"]
                }
        @issue_data.push(issue)
      end
      erb :index, locals: { issues: @issue_data }
    end

    post "/issue/reopen/:id" do 
      api = Github.new
      api.reopen_issue(params["id"].to_i)
      "Issue has been reopened."
    end

    post "/issue/close/:id" do 
      api = Github.new
        api.close_issue(params["id"].to_i)
        "Issue has been closed."
    end  

    run! if app_file == $0


  end
end

