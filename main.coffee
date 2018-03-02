Bravey = require 'bravey'

free_text = (name) -> new (Bravey.Language.IT.FreeTextEntityRecognizer)(name)
string = (name) -> new (Bravey.StringEntityRecognizer)(name)

add_doc = (nlp,doc,intent) -> nlp.addDocument doc,intent,
  fromTaggedSentence: true
  expandIntent: true

nlp = new (Bravey.Nlp.Sequential)('getdescription', stemmer: Bravey.Language.IT.Stemmer)
nlp.addEntity free_text 'topping'
food = string 'food'
food.addMatch 'pasta', 'pasta'
food.addMatch 'pizza', 'pizza'
food.addMatch 'pizza', 'pizzas'
nlp.addEntity food
add_doc nlp, 'I want {food}', 'food'
add_doc nlp, '{topping}', 'food', 'food'

console.log nlp.test('Want few pizzas, please')
console.log nlp.test('I\'d like some pasta')
console.log nlp.test('I\'d like some pasta with meatballs and cheese')
console.log nlp.test('I\'d like some pasta with meatballs and cheese on top')
console.log nlp.test('I\'d like some pasta having meatballs and cheese on top please')
