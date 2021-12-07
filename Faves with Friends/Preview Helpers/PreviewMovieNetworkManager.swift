//
//  PreviewMovieNetworkManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/30/21.
//

import Foundation


#if DEBUG
final class PreviewMovieNetworkManager: MovieNetworkManager {
	
	// MARK: - MovieNetworkManager
	func movieDetails(id: Int) async throws -> Movie {
		return await loadJSON(movieDetailJSON, withDelay: 100)
	}
	
	func movieSearch(query: String) async throws -> MovieSearchResults {
		return await loadJSON(movieSearchJSON, withDelay: 100)
	}
	
	
	// MARK: - Private Methods
	
	private func loadJSON<T: Decodable>(_ json: String, withDelay miliseconds: UInt64) async -> T {
		try? await Task.sleep(nanoseconds: miliseconds * 1_000_000)
		
		return try! JSONDecoder().decode(T.self, from: json.data(using: .utf8)!)
	}
	
	
	// MARK: Static Variables
	static var mockMovieDetails: Movie {
		try! JSONDecoder().decode(Movie.self, from: movieDetailJSON.data(using: .utf8)!)
	}
}


// MARK: - movieDetailJSON
private let movieDetailJSON =	"""
								{
									"adult": false,
									"backdrop_path": "/iPnH51khswDrYij6XIBHKlAznW.jpg",
									"belongs_to_collection": {
										"id": 10,
										"name": "Star Wars Collection",
										"poster_path": "/tdQzRSk4PXX6hzjLcQWHafYtZTI.jpg",
										"backdrop_path": "/d8duYyyC9J5T825Hg7grmaabfxQ.jpg"
									},
									"budget": 11000000,
									"genres": [
										{
											"id": 12,
											"name": "Adventure"
										},
										{
											"id": 28,
											"name": "Action"
										},
										{
											"id": 878,
											"name": "Science Fiction"
										}
									],
									"homepage": "http://www.starwars.com/films/star-wars-episode-iv-a-new-hope",
									"id": 11,
									"imdb_id": "tt0076759",
									"original_language": "en",
									"original_title": "Star Wars",
									"overview": "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.",
									"popularity": 54.163,
									"poster_path": "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
									"production_companies": [
										{
											"id": 1,
											"logo_path": "/o86DbpburjxrqAzEDhXZcyE8pDb.png",
											"name": "Lucasfilm Ltd.",
											"origin_country": "US"
										},
										{
											"id": 25,
											"logo_path": "/qZCc1lty5FzX30aOCVRBLzaVmcp.png",
											"name": "20th Century Fox",
											"origin_country": "US"
										}
									],
									"production_countries": [
										{
											"iso_3166_1": "US",
											"name": "United States of America"
										}
									],
									"release_date": "1977-05-25",
									"revenue": 775398007,
									"runtime": 121,
									"spoken_languages": [
										{
											"english_name": "English",
											"iso_639_1": "en",
											"name": "English"
										}
									],
									"status": "Released",
									"tagline": "A long time ago in a galaxy far, far away...",
									"title": "Star Wars",
									"video": false,
									"vote_average": 8.2,
									"vote_count": 16329
								}
								"""


// MARK: - movieSearchJSON
private let movieSearchJSON = 	"""
								{
									"page": 1,
									"results": [
										{
											"adult": false,
											"backdrop_path": "/iPnH51khswDrYij6XIBHKlAznW.jpg",
											"genre_ids": [
												12,
												28,
												878
											],
											"id": 11,
											"original_language": "en",
											"original_title": "Star Wars",
											"overview": "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.",
											"popularity": 54.163,
											"poster_path": "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
											"release_date": "1977-05-25",
											"title": "Star Wars",
											"video": false,
											"vote_average": 8.2,
											"vote_count": 16325
										},
										{
											"adult": false,
											"backdrop_path": "/f53Jujiap580mgfefID0T0g2e17.jpg",
											"genre_ids": [
												10751,
												16,
												878,
												35
											],
											"id": 857702,
											"original_language": "en",
											"original_title": "LEGO Star Wars Terrifying Tales",
											"overview": "Poe Dameron and BB-8 must face the greedy crime boss Graballa the Hutt, who has purchased Darth Vader’s castle and is renovating it into the galaxy’s first all-inclusive Sith-inspired luxury hotel.",
											"popularity": 148.551,
											"poster_path": "/fYiaBZDjyXjvlY6EDZMAxIhBO1I.jpg",
											"release_date": "2021-10-01",
											"title": "LEGO Star Wars Terrifying Tales",
											"video": false,
											"vote_average": 6.8,
											"vote_count": 109
										},
										{
											"adult": false,
											"backdrop_path": "/k6EOrckWFuz7I4z4wiRwz8zsj4H.jpg",
											"genre_ids": [
												28,
												12,
												878,
												14
											],
											"id": 140607,
											"original_language": "en",
											"original_title": "Star Wars: The Force Awakens",
											"overview": "Thirty years after defeating the Galactic Empire, Han Solo and his allies face a new threat from the evil Kylo Ren and his army of Stormtroopers.",
											"popularity": 60.789,
											"poster_path": "/wqnLdwVXoBjKibFRR5U3y0aDUhs.jpg",
											"release_date": "2015-12-15",
											"title": "Star Wars: The Force Awakens",
											"video": false,
											"vote_average": 7.3,
											"vote_count": 16393
										},
										{
											"adult": false,
											"backdrop_path": "/epVMXf10WqFkONzKR8V76Ypj5Y3.jpg",
											"genre_ids": [
												878,
												28,
												12,
												14,
												18
											],
											"id": 181808,
											"original_language": "en",
											"original_title": "Star Wars: The Last Jedi",
											"overview": "Rey develops her newly discovered abilities with the guidance of Luke Skywalker, who is unsettled by the strength of her powers. Meanwhile, the Resistance prepares to do battle with the First Order.",
											"popularity": 53.427,
											"poster_path": "/kOVEVeg59E0wsnXmF9nrh6OmWII.jpg",
											"release_date": "2017-12-13",
											"title": "Star Wars: The Last Jedi",
											"video": false,
											"vote_average": 6.9,
											"vote_count": 12446
										},
										{
											"adult": false,
											"backdrop_path": "/SPkEiZGxq5aHWQ2Zw7AITwSEo2.jpg",
											"genre_ids": [
												28,
												12,
												878
											],
											"id": 181812,
											"original_language": "en",
											"original_title": "Star Wars: The Rise of Skywalker",
											"overview": "The surviving Resistance faces the First Order once again as the journey of Rey, Finn and Poe Dameron continues. With the power and knowledge of generations behind them, the final battle begins.",
											"popularity": 61.05,
											"poster_path": "/db32LaOibwEliAmSL2jjDF6oDdj.jpg",
											"release_date": "2019-12-18",
											"title": "Star Wars: The Rise of Skywalker",
											"video": false,
											"vote_average": 6.5,
											"vote_count": 7250
										},
										{
											"adult": false,
											"backdrop_path": "/x27wDu2yYCMQeLpup1CDY2CtL9t.jpg",
											"genre_ids": [
												878,
												12,
												28,
												80,
												37
											],
											"id": 348350,
											"original_language": "en",
											"original_title": "Solo: A Star Wars Story",
											"overview": "Through a series of daring escapades deep within a dark and dangerous criminal underworld, Han Solo meets his mighty future copilot Chewbacca and encounters the notorious gambler Lando Calrissian.",
											"popularity": 40.476,
											"poster_path": "/4oD6VEccFkorEBTEDXtpLAaz0Rl.jpg",
											"release_date": "2018-05-15",
											"title": "Solo: A Star Wars Story",
											"video": false,
											"vote_average": 6.6,
											"vote_count": 6661
										},
										{
											"adult": false,
											"backdrop_path": "/6t8ES1d12OzWyCGxBeDYLHoaDrT.jpg",
											"genre_ids": [
												28,
												12,
												878
											],
											"id": 330459,
											"original_language": "en",
											"original_title": "Rogue One: A Star Wars Story",
											"overview": "A rogue band of resistance fighters unite for a mission to steal the Death Star plans and bring a new hope to the galaxy.",
											"popularity": 40.278,
											"poster_path": "/5jX3p0apUG5bkMHtnKZch0xpkBS.jpg",
											"release_date": "2016-12-14",
											"title": "Rogue One: A Star Wars Story",
											"video": false,
											"vote_average": 7.5,
											"vote_count": 12614
										},
										{
											"adult": false,
											"backdrop_path": "/sNNFLEcAuy4C3RyXCnKoArn7Aty.jpg",
											"genre_ids": [
												16,
												28,
												878,
												12
											],
											"id": 12180,
											"original_language": "en",
											"original_title": "Star Wars: The Clone Wars",
											"overview": "Set between Episode II and III, The Clone Wars is the first computer animated Star Wars film. Anakin and Obi Wan must find out who kidnapped Jabba the Hutt's son and return him safely. The Seperatists will try anything to stop them and ruin any chance of a diplomatic agreement between the Hutts and the Republic.",
											"popularity": 26.682,
											"poster_path": "/ywRtBu88SLAkNxD0GFib6qsFkBK.jpg",
											"release_date": "2008-08-05",
											"title": "Star Wars: The Clone Wars",
											"video": false,
											"vote_average": 6.1,
											"vote_count": 1472
										},
										{
											"adult": false,
											"backdrop_path": "/1Lhc32P0a62BgMFgd20wXR1osR3.jpg",
											"genre_ids": [
												16,
												10751,
												12,
												35,
												878
											],
											"id": 732670,
											"original_language": "en",
											"original_title": "The Lego Star Wars Holiday Special",
											"overview": "As her friends prep for a Life Day holiday celebration, Rey journeys with BB-8 on a quest to gain a deeper knowledge of the Force at a mysterious Jedi Temple. There, she embarks on a cross-timeline adventure through beloved moments in Star Wars history, coming into contact with iconic heroes and villains from all eras of the saga. But will she make it back in time for the Life Day feast?",
											"popularity": 34.227,
											"poster_path": "/zyzJSI7UZZzz5Toj10rYGF5689z.jpg",
											"release_date": "2020-11-17",
											"title": "The Lego Star Wars Holiday Special",
											"video": false,
											"vote_average": 6.7,
											"vote_count": 204
										},
										{
											"adult": false,
											"backdrop_path": "/5fu7fzy4NZTsL1Jap00UBIInAuB.jpg",
											"genre_ids": [
												12,
												28,
												878
											],
											"id": 1893,
											"original_language": "en",
											"original_title": "Star Wars: Episode I - The Phantom Menace",
											"overview": "Anakin Skywalker, a young slave strong with the Force, is discovered on Tatooine. Meanwhile, the evil Sith have returned, enacting their plot for revenge against the Jedi.",
											"popularity": 31.005,
											"poster_path": "/6wkfovpn7Eq8dYNKaG5PY3q2oq6.jpg",
											"release_date": "1999-05-19",
											"title": "Star Wars: Episode I - The Phantom Menace",
											"video": false,
											"vote_average": 6.5,
											"vote_count": 11588
										},
										{
											"adult": false,
											"backdrop_path": "/c8XIFuJCPTtTJdSRpqnUoMr6eK1.jpg",
											"genre_ids": [
												878
											],
											"id": 667574,
											"original_language": "en",
											"original_title": "Battle Star Wars",
											"overview": "When the leader of the evil Coalition threatens to destroy a Rebel planet for its resources, his daughter will have no choice but to join the Rebel side and fight for what is right.",
											"popularity": 9.328,
											"poster_path": "/ocA0ECiFoB4d1HITyEDQlLk7x84.jpg",
											"release_date": "2020-01-28",
											"title": "Battle Star Wars",
											"video": false,
											"vote_average": 5.3,
											"vote_count": 28
										},
										{
											"adult": false,
											"backdrop_path": "/pXnNSeyTCUebjpHTiZt7v6FZId0.jpg",
											"genre_ids": [
												12,
												28,
												878
											],
											"id": 1894,
											"original_language": "en",
											"original_title": "Star Wars: Episode II - Attack of the Clones",
											"overview": "Following an assassination attempt on Senator Padmé Amidala, Jedi Knights Anakin Skywalker and Obi-Wan Kenobi investigate a mysterious plot that could change the galaxy forever.",
											"popularity": 26.805,
											"poster_path": "/oZNPzxqM2s5DyVWab09NTQScDQt.jpg",
											"release_date": "2002-05-15",
											"title": "Star Wars: Episode II - Attack of the Clones",
											"video": false,
											"vote_average": 6.5,
											"vote_count": 10470
										},
										{
											"adult": false,
											"backdrop_path": "/7J6iJrsXz5PpkTzNfLWM73u6EAy.jpg",
											"genre_ids": [
												878,
												12,
												28
											],
											"id": 1895,
											"original_language": "en",
											"original_title": "Star Wars: Episode III - Revenge of the Sith",
											"overview": "The evil Darth Sidious enacts his final plan for unlimited power -- and the heroic Jedi Anakin Skywalker must choose a side.",
											"popularity": 25.859,
											"poster_path": "/xfSAoBEm9MNBjmlNcDYLvLSMlnq.jpg",
											"release_date": "2005-05-17",
											"title": "Star Wars: Episode III - Revenge of the Sith",
											"video": false,
											"vote_average": 7.4,
											"vote_count": 10859
										},
										{
											"adult": false,
											"backdrop_path": "/uNjBnOmdjZoiWTLQ938YJZ1cYVU.jpg",
											"genre_ids": [
												16,
												35,
												10751,
												878,
												12,
												10770
											],
											"id": 392216,
											"original_language": "en",
											"original_title": "Phineas and Ferb: Star Wars",
											"overview": "Phineas and Ferb become the galaxy's unlikeliest last hope when they must return the Death Star plans to the Rebel Alliance.",
											"popularity": 10.047,
											"poster_path": "/xomphpz7MIasqVluPX83TjoTL8G.jpg",
											"release_date": "2014-07-26",
											"title": "Phineas and Ferb: Star Wars",
											"video": false,
											"vote_average": 7,
											"vote_count": 129
										},
										{
											"adult": false,
											"backdrop_path": null,
											"genre_ids": [
												16,
												35,
												878
											],
											"id": 42979,
											"original_language": "en",
											"original_title": "Robot Chicken: Star Wars",
											"overview": "A series of 30 sketches, following the hilarious antics of various characters from a galaxy, far, far away.",
											"popularity": 11.291,
											"poster_path": "/h44WN4mVJ6wEpJgLaaNoFjv0NAo.jpg",
											"release_date": "2007-07-17",
											"title": "Robot Chicken: Star Wars",
											"video": false,
											"vote_average": 7.2,
											"vote_count": 184
										},
										{
											"adult": false,
											"backdrop_path": "/ae9xlnkS2qb5Dy9Mtlu68AWh42O.jpg",
											"genre_ids": [
												12,
												35,
												10751,
												878,
												10770
											],
											"id": 74849,
											"original_language": "en",
											"original_title": "The Star Wars Holiday Special",
											"overview": "Luke Skywalker and Han Solo battle evil Imperial forces to help Chewbacca reach his imperiled family on the Wookiee planet - in time for Life Day, their most important day of the year!",
											"popularity": 13.333,
											"poster_path": "/1TY4OAkcHRovlHDxSLW7UDJlild.jpg",
											"release_date": "1978-12-01",
											"title": "The Star Wars Holiday Special",
											"video": false,
											"vote_average": 3.3,
											"vote_count": 336
										},
										{
											"adult": false,
											"backdrop_path": null,
											"genre_ids": [
												99
											],
											"id": 435365,
											"original_language": "en",
											"original_title": "The Story of Star Wars",
											"overview": "The Skywalker family is at the heart of the Star Wars saga. Now hear the inside story of Luke and Anakin Skywalker from the characters who witnessed it all: the famous droid duo C-3PO and R2-D2. Episodes IV,V and VI are explored in \"The Story of Luke Skywalker,\" which follows the young man escaping from his daily chores on Tatooine to his becoming a hero in the Rebal Alliance. In \"The Story of Anakin Skywalker,\" you'll go behind the mask of the greatest Star Wars villain and discover how Darth Vader started life as a young Podracing Champ on Tatooine and later became a headstrong young Jedi seduced by the Dark Side of the Force. With clips from the Star Wars films, C-3PO and R2-D2 take you on an hour-long journey through the saga and prepare you for the explosive final chapter: Star Wars: Episode III Revenge of the Sith.",
											"popularity": 13.038,
											"poster_path": "/fvw9W7ds0Q51hQIbS7JoUBqL3tK.jpg",
											"release_date": "2004-08-18",
											"title": "The Story of Star Wars",
											"video": false,
											"vote_average": 7.6,
											"vote_count": 13
										},
										{
											"adult": false,
											"backdrop_path": "/hVl0qfLZ5loznDgQ0HxCTZqvZhz.jpg",
											"genre_ids": [
												10751,
												16,
												878,
												35,
												12,
												18
											],
											"id": 70608,
											"original_language": "en",
											"original_title": "LEGO Star Wars: The Padawan Menace",
											"overview": "Master Yoda must go retrieve secret battle plans. However, things become a little more complicated when a class of younglings join the mission.",
											"popularity": 11.9,
											"poster_path": "/lcAA36kzOahKXVwWeJLaepMr58M.jpg",
											"release_date": "2011-07-22",
											"title": "LEGO Star Wars: The Padawan Menace",
											"video": false,
											"vote_average": 6.4,
											"vote_count": 103
										},
										{
											"adult": false,
											"backdrop_path": null,
											"genre_ids": [
												99
											],
											"id": 378386,
											"original_language": "en",
											"original_title": "Star Wars: Greatest Moments",
											"overview": "Alex Zane counts down the top 20 Star Wars moments as voted by the public. Includes contributions from famous fans as well as the stars and crew of the intergalactic saga.",
											"popularity": 7.197,
											"poster_path": "/zIffPwISrW48qSmvAXEV27lBTMA.jpg",
											"release_date": "2015-12-26",
											"title": "Star Wars: Greatest Moments",
											"video": false,
											"vote_average": 6.4,
											"vote_count": 23
										},
										{
											"adult": false,
											"backdrop_path": null,
											"genre_ids": [
												35,
												878,
												16
											],
											"id": 51888,
											"original_language": "en",
											"original_title": "Robot Chicken: Star Wars Episode III",
											"overview": "Robot Chicken: Star Wars Episode III, directed by Chris McKay, combines the satirical sensibilities of Green and Matthew Senreich's Robot Chicken with characters of the Star Wars universe.",
											"popularity": 10.182,
											"poster_path": "/mi2lVho2zpfwcxI6yC1QYJi435D.jpg",
											"release_date": "2010-12-19",
											"title": "Robot Chicken: Star Wars Episode III",
											"video": false,
											"vote_average": 7.5,
											"vote_count": 109
										}
									],
									"total_pages": 8,
									"total_results": 141
								}
								"""

#endif
