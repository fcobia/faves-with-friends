//
//  MockMultiSearchJSON.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import Foundation


#if DEBUG
struct MockMultiSearchJSON: MockJSON {
	typealias JSONType = MultiSearchResults
	
	static let json =	"""
						{
							"page": 1,
							"results": [
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										18
									],
									"id": 531236,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "I Am John Wayne",
									"overview": "An young urban cowboy copes with the death of his best friend.",
									"popularity": 1.344,
									"poster_path": "/tpdFWsjpmGyaLFFOy2dFNQ19xoq.jpg",
									"release_date": "2012-03-01",
									"title": "I Am John Wayne",
									"video": false,
									"vote_average": 0,
									"vote_count": 0
								},
								{
									"adult": false,
									"gender": 2,
									"id": 4165,
									"known_for": [
										{
											"adult": false,
											"backdrop_path": "/aZD1nLaDmmLXvtI2QyPL5rIBsnW.jpg",
											"genre_ids": [
												37
											],
											"id": 301,
											"media_type": "movie",
											"original_language": "en",
											"original_title": "Rio Bravo",
											"overview": "The sheriff of a small town in southwest Texas must keep custody of a murderer whose brother, a powerful rancher, is trying to help him escape. After a friend is killed trying to muster support for him, he and his deputies - a disgraced drunk and a cantankerous old cripple - must find a way to hold out against the rancher's hired guns until the marshal arrives. In the meantime, matters are complicated by the presence of a young gunslinger - and a mysterious beauty who just came in on the last stagecoach.",
											"poster_path": "/5hFxzqpucuT3AjnvcO1pHkR122S.jpg",
											"release_date": "1959-03-17",
											"title": "Rio Bravo",
											"video": false,
											"vote_average": 7.9,
											"vote_count": 793
										},
										{
											"adult": false,
											"backdrop_path": "/wTSv5HEJvRIxGrj14lovNRQ2Gyf.jpg",
											"genre_ids": [
												37
											],
											"id": 3114,
											"media_type": "movie",
											"original_language": "en",
											"original_title": "The Searchers",
											"overview": "As a Civil War veteran spends years searching for a young niece captured by Indians, his motivation becomes increasingly questionable.",
											"poster_path": "/jLBmgW0epNzJ1N9uzaVCjbyT94v.jpg",
											"release_date": "1956-05-07",
											"title": "The Searchers",
											"video": false,
											"vote_average": 7.7,
											"vote_count": 977
										},
										{
											"adult": false,
											"backdrop_path": "/afH7n1HMvzHaOkxM3h5XXvErK0j.jpg",
											"genre_ids": [
												37
											],
											"id": 11697,
											"media_type": "movie",
											"original_language": "en",
											"original_title": "The Man Who Shot Liberty Valance",
											"overview": "A senator, who became famous for killing a notorious outlaw, returns for the funeral of an old friend and tells the truth about his deed.",
											"poster_path": "/4efvLpJXzrVMW72blwub9wWYCmc.jpg",
											"release_date": "1962-04-15",
											"title": "The Man Who Shot Liberty Valance",
											"video": false,
											"vote_average": 7.8,
											"vote_count": 773
										}
									],
									"known_for_department": "Acting",
									"media_type": "person",
									"name": "John Wayne",
									"popularity": 5.663,
									"profile_path": "/6he8USrtKQMxatYFNRIzzuiZS6c.jpg"
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										35
									],
									"id": 49301,
									"media_type": "movie",
									"original_language": "fr",
									"original_title": "Je t'aime John Wayne",
									"overview": "Belmonde lives in 1990s London as an iconic , cool Frenchman modelled on the new wave cinema of the 1960s. Really he is English and middle class – a fact that his family won't let him forget!",
									"popularity": 2.012,
									"poster_path": "/t1pTaZ0PIYg0UUu3nAbeY5fs870.jpg",
									"release_date": "2000-01-01",
									"title": "Je t'aime John Wayne",
									"video": false,
									"vote_average": 5.7,
									"vote_count": 16
								},
								{
									"adult": false,
									"backdrop_path": "/1P0vQoZYoMG1LvtHKgLl6pV2XQL.jpg",
									"genre_ids": [
										99
									],
									"id": 653831,
									"media_type": "movie",
									"original_language": "fr",
									"original_title": "John Wayne - L'Amérique à tout prix",
									"overview": "This is the story of a man who climbed the Hollywood ladder, one rung at a time, until he reached the top and became the most popular American actor of his era.",
									"popularity": 1.161,
									"poster_path": "/oTwOCKk8sXaJQDNy0uqS1klkBfT.jpg",
									"release_date": "2019-12-08",
									"title": "John Wayne - America at All Costs",
									"video": false,
									"vote_average": 8,
									"vote_count": 1
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 436201,
									"media_type": "movie",
									"original_language": "pt",
									"original_title": "O Homem que Matou John Wayne",
									"overview": "",
									"popularity": 1.4,
									"poster_path": "/nvFrqfbc9kEzb4poxoHYCbSdR5Y.jpg",
									"release_date": "2017-01-20",
									"title": "O Homem que Matou John Wayne",
									"video": false,
									"vote_average": 5,
									"vote_count": 1
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [],
									"id": 383204,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "John Wayne Hated Horses",
									"overview": "A father and his young son share a house, a yard and very different ideas about masculinity and appropriate uses of army toys. The father and son both assert themselves with action rather than words.",
									"popularity": 1.093,
									"poster_path": null,
									"release_date": "2009-03-14",
									"title": "John Wayne Hated Horses",
									"video": false,
									"vote_average": 0,
									"vote_count": 0
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 284400,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "JOHN WAYNE - AMERICAN LEGEND",
									"overview": "This installment in A&amp;E's Biography series follows the life of John Wayne from his troubled childhood to his peak as America's biggest box-office draw to his later years as a controversial conservative icon. Examined closely, Wayne's life is a startling series of contradictions. He was a member of his high school's Shakespeare club who began his career by acting in scores of B-grade Westerns, and though he avoided military service, he was considered an American hero. Filled with well-chosen archival stills, as well as seldom-seen early clips, this video also features interviews with fellow actors Charlton Heston and Ron Howard, as well as writer and scholar Garry Wills (author of a brilliant intellectual study of Wayne's work and life, John Wayne's America).",
									"popularity": 0.6,
									"poster_path": null,
									"release_date": "1998-03-14",
									"title": "JOHN WAYNE - AMERICAN LEGEND",
									"video": true,
									"vote_average": 4,
									"vote_count": 2
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [],
									"id": 327017,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "John Wayne and Chisum",
									"overview": "Documentary included in the DVD version of 'Chisum'",
									"popularity": 0.6,
									"poster_path": null,
									"release_date": "1970-01-01",
									"title": "John Wayne and Chisum",
									"video": false,
									"vote_average": 6.5,
									"vote_count": 2
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 616174,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "John Wayne Gacy: Defending a Monster",
									"overview": "'Sam, could you do me a favor?'  A seemingly simple request sparks the story that has now become part of America’s true crime hall of fame - the journey of a young lawyer, fresh from the Public Defender’s Office, whose first client in private practice turns out to be the most evil serial killer in our nation's history.",
									"popularity": 1.4,
									"poster_path": "/zti56ETt1Jy8YccD2KbVq86XiCe.jpg",
									"release_date": "2019-07-25",
									"title": "John Wayne Gacy: Defending a Monster",
									"video": false,
									"vote_average": 0,
									"vote_count": 0
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 284330,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "The John Wayne Story - The Later Years",
									"overview": "See the legendary John Wayne at his greatest in two-fisted action, interviews, rare photos, and more, in this documentary covering his screen career from Big Jim McLain to his final film, The Shootist. Back in the saddle with Westerns like Hondo, The Searchers, Rio Bravo, McLintock!, and Chisum, he also varied his output in The High and the Mighty, Blood Alley, Wings of Eagles, McQ, and Brannigan. The Duke even directed himself in The Alamo and The Green Berets, and finally won a long-awaited Academy Award as the one-eyed lawman in True Grit, a role he repeated in Rooster Cogburn. See Wayne promoting his protégé, James Arness, in Gunsmoke; making public service appearances for the Red Cross, Christmas Seals, and the American Cancer Society; and receiving his Oscar.",
									"popularity": 1.376,
									"poster_path": "/fxtTdkhgSeF1QwdmvMiZEyy43Qg.jpg",
									"release_date": "1993-05-15",
									"title": "The John Wayne Story - The Later Years",
									"video": false,
									"vote_average": 0,
									"vote_count": 0
								},
								{
									"backdrop_path": "/tvt0tNVUdQLZoabP5B7n4VRGrWf.jpg",
									"first_air_date": "2021-03-25",
									"genre_ids": [
										99
									],
									"id": 121718,
									"media_type": "tv",
									"name": "John Wayne Gacy: Devil in Disguise",
									"origin_country": [],
									"original_language": "en",
									"original_name": "John Wayne Gacy: Devil in Disguise",
									"overview": "The chilling story of one of the world’s most notorious serial killers told through the words of Gacy himself, those who were forever changed by his unspeakable deeds and those who believe that the full truth remains concealed to this day.",
									"popularity": 1.44,
									"poster_path": "/3LZHmVND6WyY0bhoLlyWPRl5Pa1.jpg",
									"vote_average": 6.6,
									"vote_count": 5
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 90959,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "John Wayne Standing Tall",
									"overview": "Profile of one of the world's most popular motion picture stars, told through interviews with some of the artists who worked with him, family, friends, and excerpts from many of his films and television appearances.",
									"popularity": 0.62,
									"poster_path": null,
									"release_date": "1989-03-01",
									"title": "John Wayne Standing Tall",
									"video": false,
									"vote_average": 6,
									"vote_count": 1
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 316671,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "The John Wayne Story: The Early Years",
									"overview": "Film clips, trailers and rare photos combine to tell the story of John Wayne's evolution from mild-mannered USC student Marion Morrison to the ultimate Western hero of the silver screen. Highlights include clips from his silent-movie debut, his first leading role, and his bizarre failed attempt to become a singing cowboy. Other excerpts include scenes from Flying Tigers, The Quiet Man and his breakthrough, Stagecoach.",
									"popularity": 1.448,
									"poster_path": "/rSKvhqS1oCctkul6rYCuL48tlxw.jpg",
									"release_date": "1993-02-04",
									"title": "The John Wayne Story: The Early Years",
									"video": false,
									"vote_average": 1,
									"vote_count": 1
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 416218,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "John Wayne on Film",
									"overview": "A retrospective of the career of actor John Wayne, showing clips from many of his most famous films.",
									"popularity": 0.6,
									"poster_path": null,
									"release_date": "2016-09-16",
									"title": "John Wayne on Film",
									"video": false,
									"vote_average": 10,
									"vote_count": 1
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										35
									],
									"id": 264126,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "Five Ways John Wayne Didn't Die",
									"overview": "A man has passed away but hasn't been buried yet. Thinking that God has a furtive way about death, the man believes he can get the last laugh.",
									"popularity": 0.877,
									"poster_path": null,
									"release_date": "2002-06-01",
									"title": "Five Ways John Wayne Didn't Die",
									"video": false,
									"vote_average": 0,
									"vote_count": 0
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										36
									],
									"id": 98572,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "John Wayne: An American Icon",
									"overview": "",
									"popularity": 0.844,
									"poster_path": null,
									"release_date": "2012-04-03",
									"title": "John Wayne: An American Icon",
									"video": false,
									"vote_average": 0,
									"vote_count": 0
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 483873,
									"media_type": "movie",
									"original_language": "de",
									"original_title": "John Wayne - Eine amerikanische Legende",
									"overview": "",
									"popularity": 0.6,
									"poster_path": "/v3qSQx5FmmWqLvGKsrisiQ1gSjC.jpg",
									"release_date": "2009-01-01",
									"title": "John Wayne - Eine amerikanische Legende",
									"video": false,
									"vote_average": 6,
									"vote_count": 1
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 483869,
									"media_type": "movie",
									"original_language": "de",
									"original_title": "John Wayne - Ein Leben für den Film",
									"overview": "",
									"popularity": 0.926,
									"poster_path": "/wH7dZFgVd8oKB9sNToVTZDKyU30.jpg",
									"release_date": "2000-01-01",
									"title": "John Wayne - Ein Leben für den Film",
									"video": false,
									"vote_average": 0,
									"vote_count": 0
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 246001,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "The Story of John Wayne",
									"overview": "From the John Wayne Tribute Collection  A Tribute Restrospect celebrating John Wayne's illustrious career and personal highlights.",
									"popularity": 0.6,
									"poster_path": null,
									"release_date": "2011-08-24",
									"title": "The Story of John Wayne",
									"video": false,
									"vote_average": 1,
									"vote_count": 1
								},
								{
									"adult": false,
									"backdrop_path": null,
									"genre_ids": [
										99
									],
									"id": 140048,
									"media_type": "movie",
									"original_language": "en",
									"original_title": "John Wayne: Bigger Than Life",
									"overview": "“The Duke” (John Wayne) really was bigger than life. I loved this guy from the moment I went to one of my very first theatre films. The movie in question was The Cowboys in 1972. I apologize if this is a spoiler, 39 years later, but the climactic scene of Wayne being killed by Bruce Dern still gets to me.",
									"popularity": 0.6,
									"poster_path": null,
									"release_date": "1990-01-01",
									"title": "John Wayne: Bigger Than Life",
									"video": false,
									"vote_average": 4,
									"vote_count": 1
								}
							],
							"total_pages": 3,
							"total_results": 51
						}
						"""
}
#endif
