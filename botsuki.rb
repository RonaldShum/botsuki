require 'discordrb'
require 'simple-random'
require 'marky_markov'
require 'yaml'

$config = YAML.load_file('config.yaml')
$flavours = $config['flavoursFile']

$bsuki = Discordrb::Commands::CommandBot.new(
  token: $config['token'],
  prefix: $config['prefix'],
  advanced_functionality: true,
  spaces_allowed: true,
  ignore_bots: true)

$bsuki.command :monika \
do |event|
  event.channel.send_embed \
  do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(
      url: $config['monikammm'])
  end
end

$bsuki.command :sayori \
do |event|
  event.channel.send_message("Bring the ropes")
end

$bsuki.command :cupcake \
do |event|
  random = SimpleRandom.new
  random.set_seed
  wordsToUse = random.uniform(1, 5).round
  markov = MarkyMarkov::TemporaryDictionary.new
  markov.parse_file $flavours
  event.channel.send_message("Here's a #{markov.generate_n_words wordsToUse} \
cupcake, <@#{event.author.id.to_s}>!")
  puts markov.clear!
end

$bsuki.run