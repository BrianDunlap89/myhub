module Myhub
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    # Your code here too!
    def initialize
      @headers = {
        "Authorization" => "token #{ENV["AUTH_TOKEN"]}",
        "User-Agent"    => "HTTParty"
      }
    end

    def list_issues
      Github.get("/orgs/TIY-ATL-ROR-2015-Sep/issues",
                 headers: @headers, query: { state: "all" })
    end

    def reopen_issue(number)
      Github.patch("/repos/TIY-ATL-ROR-2015-Sep/assignments/issues/#{number}", 
                   headers: @headers, body: { state: "open" }.to_json)
    end

    def close_issue(number)
      Github.patch("/repos/TIY-ATL-ROR-2015-Sep/assignments/issues/#{number}", 
                   headers: @headers, body: { state: "closed" }.to_json)
    end

  end
end
