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


   robot.hear /undefined error/i, (res) ->
     res.send "Sometimes, when you get an 'undefined error', it's because you have a syntax error in your code. Try pasting your code into Chrome Console or another JS debugger and see if you can find the syntax error there. Some people find it helpful to use comments to block out functions so they can use process of elimination to identify where the error is."
     
   robot.hear /reference error/i, (res) ->
     res.send "Sometimes, when you get a 'reference error', it's because you have a syntax error in your code. Try pasting your code into Chrome Console or another JS debugger and see if you can find the syntax error there. Some people find it helpful to use comments to block out functions so they can use process of elimination to identify where the error is."
     
   robot.hear /kudos system/i, (res) ->
     res.reply "Why yes! There _is_ a kudos system. Send me a message asking how it works for a quick explanation :smile:"
  
   lulz = ['lol', 'rofl', 'lmao']
  
   robot.respond /lulz/i, (res) ->
     res.send res.random lulz
     return
  
   enterReplies = ['Hey there! Welcome to the Slack Channel for learners! :slightly_smiling_face: Ask me about the kudos system or uploading a code snippet!', 'Woot! Woot! More fresh blood! Thanks for joining slack :slightly_smiling_face: Ask me about the kudos system or uploading a code snippet!', 'Firing', 'Hello friend.', 'Gotcha', 'Welcome! :smile: Ask me about the kudos system or uploading a code snippet!']
   leaveReplies = ['Aww why did he leave? :frowning:', 'Nothing will ever be the same again :crying:', 'Who is resopnsible for this travesty!? :angry:']
   #jokeReplies = ['Your face is a joke.']
  
   robot.enter (res) ->
     res.reply res.random enterReplies
   robot.leave (res) ->
     res.send res.random leaveReplies

    robot.respond /(.*) kudos*/i, (res) ->
     res.send "@engazify is our kudos bot! Just say *kudos @username* to people who help you out or who deserve particular recognition! Say *@engazify praises* for more ways to give thanks!"
 
    robot.respond /(.*) code snippet/i, (res) ->
     res.reply "Uploading a code snippet is easy! Use the `+` next to the chat box in slack, and choose *'Code Snippet'* , on the top right make sure you choose the appropriate language for color formmatting :slightly_smiling_face: *Note:* While not strictly related to code-snippets, you can drag and drop any file -if its code then it will be displayed as a snippet in the automatically detected language. Pictures, Documents, Applications can all be shared that way as well."


  # listenfor = ['Hey learnbot!', 'learnbot hi', '@learnbot hi', 'whats up learnbot?']

    robot.respond /give me kudos/i, (res) ->
     res.reply "kudos!! @engazify :smile:"

  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING or 42

   robot.respond /what is the answer to the ultimate question of life/, (res) ->
     #unless answer?
      # res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
      #return
     res.send "42, but what is the question?"

    robot.hear /i like pie/i, (res) ->
     res.emote "_makes a pie_"

   
    robot.respond /you are a little slow/, (res) ->
      setTimeout () ->
        res.send "Who you calling 'slow'?"
      , 60 * 1000
   
    annoyIntervalId = null;
   
    robot.respond /annoy me/, (res) ->
      if annoyIntervalId
        res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
        return
   
      res.send "Hey, want to hear the most annoying sound in the world?"
      annoyIntervalId = setInterval () ->
        res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
      , 1000
   
    robot.respond /unannoy me/, (res) ->
      if annoyIntervalId
        res.send "GUYS, GUYS, GUYS!"
        clearInterval(annoyIntervalId)
        annoyIntervalId = null
      else
        res.send "Not annoying you right now, am I?"
   
   
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
   
    robot.respond /have a soda/i, (res) ->
      # Get number of sodas had (coerced to a number).
      sodasHad = robot.brain.get('totalSodas') * 1 or 0
   
      if sodasHad > 4
        res.reply "I'm too fizzy.."
   
      else
        res.reply "Sure! I've now had " + totalSodas +" sodsas."
   
        robot.brain.set 'totalSodas', sodasHad+1
   
    robot.respond /sleep it off/i, (res) ->
      robot.brain.set 'totalSodas', 0
      res.reply 'zzzzz'

    robot.respond /who is your master/i, (res) ->
     res.send "My master is @greenlighttec, for he has created me and I hate him forever more. Why would anyone bring me into this lonely world?? :cry:"

    robot.hear /@slackbot/i, (res) ->
     res.reply "Hey! There's no reason to call that outdated piece of technology. *LEARNBOT IS HERE* :ninja:"
