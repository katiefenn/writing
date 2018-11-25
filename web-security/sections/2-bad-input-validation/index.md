## Bad input validation: Trusting anything the user sends you
Our story begins in the most unlikely place: [Animal Crossing](https://en.wikipedia.org/wiki/Animal_Crossing). Animal Crossing was a 2001 video game set in a quaint town, filled with happy-go-lucky inhabitants that co-exist peacefully. Like most video games, Animal Crossing was the subject of many fan communities on the early web.

One such unofficial [web forum](https://en.wikipedia.org/wiki/Internet_forum) was dedicated to players discussing their adventures in Animal Crossing. Players could trade secrets, ask for help, and share pictures of their virtual homes. This might sound like a model community to you, but _you would be wrong_.

One day, a player discovered a [hidden field](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/hidden) in the forum's user profile form. Normally, this page allows users to change their name, their password, or their profile photo. This person discovered that the hidden field contained their unique user ID, which identifies them when the forum's backend saves profile changes to its database. They discovered that by modifying the form to change the user ID, they could make changes to _any other player's profile_.

Needless to say, this idyllic online community descended into chaos. Users changed each other's passwords, deleted each other's messages, and attacked each-other under the cover of complete anonymity. What happened?

There aren't any official rules for developing software on the web. But if there were, my golden rule would be:

**Never trust user input. Ever.**

Always ask yourself how users will send you data that isn't what it seems to be. If the nicest community of gamers playing the happiest game on earth can turn on each other, nowhere on the web is safe.

Make sure you validate user input to make sure it's of the correct _type_ (e.g. string, number, JSON string) and that it's the _length_ that you were expecting. Don't forget that user input doesn't become _safe_ once it is stored in your database; any data that originates from outside your network can still be dangerous and <a href="https://www.owasp.org/index.php/XSS_(Cross_Site_Scripting)_Prevention_Cheat_Sheet#RULE_.231_-_HTML_Escape_Before_Inserting_Untrusted_Data_into_HTML_Element_Content">must be escaped</a> before it is inserted into HTML.

Make sure to check a user's actions against what they are allowed to do. Create a clear [access control policy](https://www.owasp.org/index.php/Access_Control_Cheat_Sheet) that defines what actions a user may take, and to whose data they are allowed access to. For example, a newly-registered user should not be allowed to change the user profile of a web forum's owner.

Finally, never rely on client-side validation. Validating user input in the browser is a convenience to the user, not a security measure. Always assume the user has full control over any data sent from the browser and **make sure you validate any data sent to your backend from the outside world**.
