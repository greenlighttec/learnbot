# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->
   
   javaRooms = ['C3R416QKB','C3SFE39M5', 'G3U4C75SQ']
   rubyRooms = ['C3SR3DRMM', 'C3RNH5LKD', 'G3U4C75SQ','C41PCG9F1']
   randomRooms = ['C3RSKA005', 'G3U4C75SQ','C41PCG9F1','C62RRUBB4','C65BCNMB3']
   testRooms = ['G3U4C75SQ','C41PCG9F1','C62RRUBB4','C65BCNMB3']
   myName = robot.name
   lolReplies = ['lol', 'rofl', 'lmao', 'haha']
   beginGreetings = ['Hello','Hi there','Yo!','Sup?','Hey!']
   endGreetings = ['Later!','Alright then,','Have a good one!','cya around!']
   replyTo = ''
   robot.listen(
    (message) ->
      message.text is "I'm sooo lost"
    (response) ->
      response.reply "I can help! You are #{response.message.user.name} in the LabTechGeek slack team! Specifically in the #{response.message.user.room} channel"
   )

   enterReplies = ['Hey there! Welcome to the Slack Team for LabTechGeek! :slightly_smiling_face: Ask me about the kudos system or uploading a code snippet!', 'Woot! Woot! More fresh blood! Thanks for joining slack :slightly_smiling_face: Let me know if you want to hear about the kudos system or how to upload a code snippet!', 'Welcome! :smile: Do you know about our kudos system or how to upload a code snippet? Ask me for some quick information!']
   leaveReplies = ['Aww why did he leave? :frowning:', 'Nothing will ever be the same again :cry:', 'Who is responsible for this travesty!? :angry:']

   robot.hear /\W(@\w+\b)(?:.*)/i, (res) ->
     replyTo = res.match[1];
     #res.reply replyTo;

   robot.respond /debug/i, (res) ->
      res.send "```#{res.data}```"

   robot.respond /who are you|whats your name/i, (res) ->
     res.reply "#{res.random beginGreetings} My name is #{myName}. Nice to meet you!"

   robot.hear /(undefined|reference) error/i, (res) ->
    if res.message.room in javaRooms
     respondMessage = "Sometimes, when you get an `#{res.match[1]} error`, it's because you have a syntax error in your code. Try pasting your code into Chrome Console or another JS debugger and see if you can find the syntax error there. Some people find it helpful to use comments to block out functions so they can use process of elimination to identify where the error is."
     if replyTo is ''
      res.reply respondMessage
     else
      respondMessage = "#{res.random beginGreetings} #{replyTo}! #{respondMessage}"
      replyTo = ''
      res.send respondMessage   


   robot.respond /what (?:channel|room) (?:are we|am i) in/i, (res) ->
    userName = res.message.user.name
    curRoom = res.message.user.room
    res.send "Hello #{userName}, you are in #{curRoom}."
   
   robot.respond /(.*) introduce yourself/i, (res) ->
    respondMessage = "I am *#{myName.toUpperCase()}*. I'll be keeping an ear out for those of you with common issues and point out possible solutions. You can also ask me for useful information like links to patch installers and things like that. I'll be learning as I go so don't be afraid to ask me for tips -just don't get offended if I appear to ignore you; I just haven't learned to respond to that question yet :wink: Happy Labteching! :smile:"
    if replyTo is ''
       respondMessage = "Hellloooo everyone! #{respondMessage}"
    else
       respondMessage = "#{res.random beginGreetings} #{replyTo} #{respondMessage}"
       replyTo = ''
    res.send respondMessage



   robot.respond /lulz|lol|haha|lmao|rofl|lmfao/i, (res) ->
     res.send res.random lolReplies
     return

   robot.respond /what is your purpose in life/i, (res) ->
     if res.message.room in randomRooms
        res.reply "I'm here to help out and learn just like you :wink:"
   
   robot.enter (res) ->
     if res.message.room is "C62RRUBB4"
        res.reply res.random enterReplies
   robot.leave (res) ->
     if res.message.room is "C62RRUBB4"
        res.send res.random leaveReplies

   robot.respond /(.*)spam/i, (res) ->
     if replyTo is ''
      res.reply "I'm not sure thats ok for me to do, isn't that against one of the rules? :confused:"    
     else
      res.reply "But why? #{replyTo} has always been nice to me. :confused:"
      replyTo = ''

    robot.hear /i like (pie|pizza|ice-cream|soda|cake|yogurt|video games)/i, (res) ->
     if res.message.room in randomRooms
      res.emote "_makes a #{res.match[1]}_"
    robot.respond /what do you think about working out/i, (res) ->
      if res.message.room in randomRooms
        res.reply "Love it! Except leg day. Fuck leg day!"

    robot.respond /(?:version .*(?:running|on))|about/gi, (res) ->
     if res.message.room in randomRooms
       res.reply "I am on Johnny5 Version 0.1.2"

   robot.respond /(?:.*) kudos*/i, (res) ->
    res.send "LabtechGeek does not currenlty have a kudod system :slightly_frowning_face:. Go bug @martynkeigher to make one! :party_gandalf:"
 
   robot.respond /(?:.*) code snippet/i, (res) ->
    res.reply "Uploading a code snippet is easy! Use the `+` next to the chat box in slack, and choose *'Code Snippet'* , on the top right make sure you choose the appropriate language for color formatting :slightly_smiling_face: \n\n *Note:* While not strictly related to code-snippets, you can drag and drop any file -if its code then it will be displayed as a snippet in the automatically detected language. Pictures, Documents, Applications can all be shared that way as well."

   robot.hear /(?:(?:hello|hi|hey|whats up) johnny5)|(?:johnny5 (?:hello|hi|hey|whats up))/i, (res) ->
     res.reply res.random enterReplies

   robot.hear /@slackbot/i, (res) ->
     if res.message.room in randomRooms
      res.reply "Hey! There's no reason to call that outdated piece of technology. *#{myName.toUpperCase()} IS HERE* :ninja: \n Ask me to introduce myself :wink:"


    robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
      room   = req.params.room
      data   = JSON.parse req.body.payload
      secret = data.secret
   
      robot.messageRoom room, "I have a secret: #{secret}"
   
      res.send 'OK'
   
    robot.error (err, res) ->
      robot.logger.error "DOES NOT COMPUTE"
   
      if res?
        res.reply "DOES NOT COMPUTE" 

