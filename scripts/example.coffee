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
     res.send "Sometimes, when you get an 'undefined error', it's because you have a syntax error in your code. Try pasting your code into Chrome Console or another JS debugger and see if you can find the syntax error there"
  
    robot.respond /open the (.*) door/i, (res) ->
      doorType = res.match[1]
      if doorType is "pod bay"
        res.reply "I'm afraid I can't let you do that."
      else
        res.reply "Opening #{doorType} door"
   
   robot.hear /is there a kudos system/i, (res) ->
     res.reply "Why yes! There _is_ a kudos system. Send me a message asking how it works for a quick explanation :smile:"
  
   lulz = ['lol', 'rofl', 'lmao']
  
   robot.respond /lulz/i, (res) ->
     res.send res.random lulz
     return
   robot.topic (res) ->
    res.send "#{res.message.text}? That's a Paddlin'"  
  
   enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
   leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
   jokeReplies = ['Your face is a joke.']
  
   robot.enter (res) ->
     res.send res.random enterReplies
   robot.leave (res) ->
     res.send res.random leaveReplies

    robot.respond /(.*) please help me/i, (res) ->
     res.send "Who am I? Obi-Wan Kenobi? :eyes:"

  # listenfor = ['Hey learnbot!', 'learnbot hi', '@learnbot hi', 'whats up learnbot?']

    robot.respond /give me kudos/i, (res) ->
     res.reply "kudos!! @engazify :smile:"

  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING or 42

   robot.respond /what is the answer to the ultimate question of life/, (res) ->
     unless answer?
       res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
       return
     res.send "#{answer}, but what is the question?"
   
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
        res.reply "Sure! I've now had #{totalSodas} sodas."
   
        robot.brain.set 'totalSodas', sodasHad+1
   
    robot.respond /sleep it off/i, (res) ->
      robot.brain.set 'totalSodas', 0
      res.reply 'zzzzz'

    robot.respond /who is your master/i, (res) ->
     res.send "My master is @greenlighttec, for he has created me and I hate him forever more. Why would anyone bring me into this lonely world?? :cry:"

    robot.hear /@slackbot/i, (res) ->
     res.reply "Hey! There's no reason to call that outdated piece of technology. *LEARNBOT IS HERE* Ask me to help? Pleaaaseee ask me for help! :smile:"
