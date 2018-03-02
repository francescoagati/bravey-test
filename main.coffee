Bravey = require 'bravey'

free_text = (name) -> new (Bravey.Language.IT.FreeTextEntityRecognizer)(name)
string = (name) -> new (Bravey.StringEntityRecognizer)(name)

add_doc = (nlp,doc,intent) -> nlp.addDocument doc,intent,
  fromTaggedSentence: true
  expandIntent: true

seq = (name) -> new (Bravey.Nlp.Sequential)(seq, stemmer: Bravey.Language.IT.Stemmer)

log = (it) -> console.log it 

nlp = seq 'getdescription'
nlp.addEntity free_text 'topping'
food = string 'food'
food.addMatch 'pasta', 'pasta'
food.addMatch 'pizza', 'pizza'
food.addMatch 'pizza', 'pizzas'
nlp.addEntity food
add_doc nlp, 'I want {food}', 'food'
add_doc nlp, '{topping}', 'food', 'food'

log nlp.test('Want few pizzas, please')
log nlp.test('I\'d like some pasta')
log nlp.test('I\'d like some pasta with meatballs and cheese')
log nlp.test('I\'d like some pasta with meatballs and cheese on top')
log nlp.test('I\'d like some pasta having meatballs and cheese on top please')
