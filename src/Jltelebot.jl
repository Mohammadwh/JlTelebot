module Jltelebot

export message_handler,

import HTTP, Test, JSON, UUIDs

function getUpdates(token, offset=0)
    tQuery="""timeout=30&offset=$offset"""
    updates = JSON.parse(String(HTTP.request("GET","https://api.telegram.org/bot$token/getUpdates";query="$tQuery").body))
    result = updates["result"]
    return result
end

function create_message(msg)
	if haskey(msg, "message")
		msg = msg["message"]
	elseif haskey(msg, "edited_message")
		msg = msg["edited_message"]
	end	
	
	date = msg["date"]
	chat = msg["chat"]	
	message_id = msg["message_id"]
	date = date
	chat = chat
	message = Dict(
	"message_id"=>message_id,
	"date"=>date,
	"chat"=>chat,
	)
	if haskey(msg,"text")
		push!(message,"text"=>msg["text"]) 
		push!(message,"content_type"=>"text") 
	end		

	if haskey(msg,"from")
		push!(message,"from_user"=>msg["from"])
	else
		push!(message,"from_user"=>empty)
	end
	
	if haskey(msg,"forward_from")
		push!(message,"forward_from"=>msg["forward_from"])
	end	
	
	if haskey(msg,"forward_from_chat")
		push!(message,"forward_from_chat"=>msg["forward_from_chat"])
	end	

	if haskey(msg,"forward_from_message_id")
		push!(message,"forward_from_message_id"=>msg["forward_from_message_id"])
	end	
	
	if haskey(msg,"forward_signature")
		push!(message,"forward_signature"=>msg["forward_signature"])
	end	
	
	if haskey(msg,"forward_date")
		push!(message,"forward_date"=>msg["forward_date"])
	end	

	if haskey(msg,"reply_to_message")
		push!(message,"reply_to_message"=>msg["reply_to_message"])
	end	
	
	if haskey(msg,"edit_date")
		push!(message,"edit_date"=>msg["edit_date"])
	end	
	
	if haskey(msg,"media_group_id")
		push!(message,"media_group_id"=>msg["media_group_id"])
	end	
	
	if haskey(msg,"author_signature")
		push!(message,"author_signature"=>msg["author_signature"])
	end	
	
	if haskey(msg,"photo")
		push!(message,"photo"=>msg["photo"])
		push!(message,"content_type"=>"photo")
	end	
	
	if haskey(msg,"entities")	
		push!(message,"entities"=>msg["entities"])
	end		
	
	if haskey(msg,"caption_entities")
		push!(message,"caption_entities"=>msg["caption_entities"])
	end		
	
	if haskey(msg,"audio")
		push!(message,"audio"=>msg["audio"])
		push!(message,"content_type"=>"audio")
	end	
	
	if haskey(msg,"document")
		push!(message,"document"=>msg["document"])
		push!(message,"content_type"=>"document")
	end	
	
	if haskey(msg,"game")
		push!(message,"game"=>msg["game"])
		push!(message,"content_type"=>"game")
	end		
	
	if haskey(msg,"sticker")
		push!(message,"sticker"=>msg["sticker"])
		push!(message,"content_type"=>"sticker")		
	end	
	
	if haskey(msg,"video")
		push!(message,"video"=>msg["video"])
		push!(message,"content_type"=>"video")		
	end	
	
	if haskey(msg,"video_note")
		push!(message,"content_type"=>"video_note")
		push!(message,"video_note"=>msg["video_note"])
	end		

	if haskey(msg,"voice")
		push!(message,"content_type"=>"voice")
		push!(message,"video_note"=>msg["voice"])	
	end		
	
	if haskey(msg,"caption")
		push!(message,"video_note"=>msg["caption"])		
	end	
	
	if haskey(msg,"contact")
		push!(message,"contact"=>msg["contact"])	
		push!(message,"content_type"=>msg["content_type"])	
	end	
	
	if haskey(msg,"location")
		push!(message,"location"=>msg["location"])	
		push!(message,"content_type"=>msg["location"])		
	end	
	
	if haskey(msg,"venue")
		push!(message,"venue"=>msg["venue"])	
		push!(message,"content_type"=>msg["venue"])		
	end		
	
	if haskey(msg,"new_chat_member")
		nms = Dict()
		push!(message,"new_chat_members"=>nms)	
		push!(message,"content_type"=> "new_chat_members")			
		content_type = 
	end	
	
	if haskey(msg,"new_chat_members")
		chat_members = msg["new_chat_members"]
		nms = Dict()
		for m in chat_members
			push!(nms,m) 
		end		
		push!(message,"new_chat_members"=>nms)	
		push!(message,"content_type"=> "new_chat_members")		
	end	
	
	if haskey(msg,"left_chat_member")
		push!(message,"left_chat_member"=>msg["left_chat_member"])	
		push!(message,"content_type"=> "left_chat_member")			
	end	
	
	if haskey(msg,"new_chat_title")
		push!(message,"new_chat_title"=>msg["new_chat_title"])	
		push!(message,"content_type"=> "new_chat_title")				
	end	
	
	if haskey(msg,"new_chat_photo")
		push!(message,"new_chat_photo"=>msg["new_chat_photo"])	
		push!(message,"content_type"=> "new_chat_photo")		
	end	
	
	if haskey(msg,"delete_chat_photo")	
		push!(message,"new_chat_photo"=>msg["delete_chat_photo"])	
		push!(message,"content_type"=> "delete_chat_photo")		
	end	
	
	if haskey(msg,"group_chat_created")
		push!(message,"new_chat_photo"=>msg["group_chat_created"])	
		push!(message,"content_type"=> "group_chat_created")			
	end	
	
	if haskey(msg,"supergroup_chat_created")
		push!(message,"new_chat_photo"=>msg["supergroup_chat_created"])	
		push!(message,"content_type"=> "supergroup_chat_created")	
	end	
	
	if haskey(msg,"channel_chat_created")
		push!(message,"new_chat_photo"=>msg["channel_chat_created"])	
		push!(message,"content_type"=> "channel_chat_created")	
	end	
	
	if haskey(msg,"migrate_to_chat_id")
		push!(message,"new_chat_photo"=>msg["migrate_to_chat_id"])	
		push!(message,"content_type"=> "migrate_to_chat_id")		
	end	
	
	if haskey(msg,"migrate_from_chat_id")
		push!(message,"migrate_from_chat_id"=>msg["migrate_from_chat_id"])	
		push!(message,"content_type"=> "migrate_from_chat_id")		
	end	
	
	if haskey(msg,"pinned_message")
		push!(message,"migrate_from_chat_id"=>msg["pinned_message"])	
		push!(message,"content_type"=> "pinned_message")		
	end		
	if haskey(msg,"invoice")
		push!(message,"invoice"=>msg["invoice"])	
		push!(message,"content_type"=> "invoice")	
	end	
	
	if haskey(msg,"successful_payment")	
		push!(message,"successful_payment"=>msg["successful_payment"])	
		push!(message,"content_type"=> "connected_website")		
	end	
	
	if haskey(msg,"connected_website")	
		push!(message,"connected_website"=>msg["connected_website"])	
		push!(message,"content_type"=> "connected_website")		
	end	
	

	return message
end

function message_handler(token,message)
	while true
		msgQuery = getUpdates(token,offset)
		if length(msgQuery)==0
			continue
		end
		offset = maximum([ i["update_id"] for i in msgQuery ]) + 1
		for msg in msgQuery
			if message == "message"
				if (haskey(msg, "message") || haskey(msg,"edited_message"))
					msg = create_message(msg)
					return msg
				end
			if message == "inline"	
				if haskey(msg, "inline_query")
					return msg
				end			
			end
		end
	end
end

end
