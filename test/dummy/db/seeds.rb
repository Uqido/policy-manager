
user = User.create(email: 'test@test.com')

Article.create(user: user, title: 'Titolo 1', subtitle: 'Sottotitolo 1', description: 'Descrizione 1')

Article.create(user: user, title: 'Titolo 2', subtitle: 'Sottotitolo 2', description: 'Descrizione 2')

Article.create(user: user, title: 'Titolo 3', subtitle: 'Sottotitolo 3', description: 'Descrizione 3')

Article.create(user: user, title: 'Titolo 4', subtitle: 'Sottotitolo 4', description: 'Descrizione 4')

Article.create(user: user, title: 'Titolo 5', subtitle: 'Sottotitolo 5', description: 'Descrizione 5')

Article.create(user: user, title: 'Titolo 6', subtitle: 'Sottotitolo 6', description: 'Descrizione 6')

Article.create(user: user, title: 'Titolo 7', subtitle: 'Sottotitolo 7', description: 'Descrizione 7')