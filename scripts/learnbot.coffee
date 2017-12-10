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
   
   adminRooms = ['G262PSWTT']
   strictRooms = ['C65BCNMB3', 'G658U2NTF']
   randomRooms = ['G658U2NTF', 'C65BCNMB3']
   testRooms = ['G658U2NTF', 'C65BCNMB3']
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
    if res.message.room in testRooms
     res.reply "#{res.random beginGreetings} My name is #{myName}. Nice to meet you!"

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
    if res.message.room in testRooms
     res.send res.random lolReplies
     return

   robot.respond /what is your purpose in life/i, (res) ->
     if res.message.room in randomRooms
        res.reply "I'm here to help out and learn just like you :wink:"
   
   robot.enter (res) ->
     if res.message.room in testRooms
        res.reply res.random enterReplies
   robot.leave (res) ->
     if res.message.room in testRooms
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
       res.reply "I am on Geekbot Version 0.0.1"
 
   robot.hear /(?:(?:hello|hi|hey|whats up) geekbot)|(?:geekbot (?:hello|hi|hey|whats up))/i, (res) ->
     res.reply res.random enterReplies

   robot.hear /@slackbot/i, (res) ->
     if res.message.room in testRooms
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

