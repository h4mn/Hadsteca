import discord
class BotBlue(dicord.Client):
    async def on_ready(self):
        print('Welsinho dá os bemvindo a {0}!'.format(self.user))
    pass

intents = discord.Intents.default()
intents.members = True
bot = BotBlue(intents=intents)
bot.run('NjUxODgwMjEzNjI1NDM4MjI5.XegUwg.X9tLmhh-gQN3EXEM1Eka-Lt4uW4')
