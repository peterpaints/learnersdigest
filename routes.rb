# set utf-8 for outgoing
# before do
# 	headers "Content-Type" => "application/json"
# end

get '/' do
	erb :index
end

