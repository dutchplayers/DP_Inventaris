Config = {
	UseESX = false, -- if true, the player needs to pay for a ticket.
	ESXMenu = false, -- UseESX must set to true if you set his one to true.
	ESXMenuAlign = 'left', -- does only apply if ESXMenu == true
	Locale = {
		MenuTitle = 'Ziel auswählen',
		Money = 'Kaufen sie ein Flugticket für ',
		MoneyCurrency = '€',
		NoPlane = 'Es ist aktuell kein Flug geplant.',
		NoMoney = 'Nicht genug bargeld.\n',
		NoMoneyTitle = 'Armes Schwein'
	},
	Airports = {
		lsia = {
			Name ='Los Santos International',
			Ticket = vector3(-1030.80, -2493.35, 20.16),
			-- PlaneSpawn = vector4(2123.71, 4806.34, 41.2), 110.19 },
			PlaneSpawn = vector4(-1675.2446, -2798.8835, 14.5409, 327.8560),
			RunWayStart = vector3(-1792.00122, -2882.29980, 13.9440+1.0001),
			RunWayEnd = vector3(-998.5266, -3341.3579, 13.9444+1.0001),
			TaskVehicleDriveToCoordLongrange = vector3(-1461.73,-2426.62,13.94),
			TaskPlaneMission = vector3(-1571.5589, -556.7288, 114.4482),
			PlayerDropOff = vector4(-1042.0395, -2740.7780, 20.1692, 340.2285),
			Runways = {
				north = {
					west = vector4(-1543.79,-2829.19,13.96,56.23),
					east = vector4(-878.58,-3212.91,13.94,236.7),
				},
				south = {
					west = vector4(-1681.88,-2943.67,13.94,56.19),
					east = vector4(-981.5,-3348.67,13.94,236.77),
				},
				long = {
					north = vector4(-1367.59,-2264.98,13.96,326.12),
					south = vector4(-1685.33,-2823.96,19.94,148.57),
				},
			},
			Destinations = {
				ssa = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				mcaf = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				cpa = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				usaf = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				tanker = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
			},
			Zone = "AIRP"
		},
		ssa = {
			Name ='Sandy Shores',
			Ticket = vector3(1752.15, 3290.56, 41.11),
			PlaneSpawn = vector4(1599.02453, 3231.2016, 40.4115, 105.7817),
			RunWayStart = vector3(881.4462, 3060.4829, 41.1682+10.0001), -- Lande anflug
			RunWayEnd = vector3(1657.07, 3238.21, 40.5669+1.0001), -- Lande ende
			TaskVehicleDriveToCoordLongrange = vector3(1403.0020751953, 2995.9179, 40.5507),
			TaskPlaneMission = vector3(-107.2212, 2717.5534, 61.9673),
			Runways = {
				north = {
					west = {
						vector4(1104.45, 3089.16, 40.41, 103.52), -- boden nach aussen
						vector4(2019.48, 335.77, 152.37, 230.51), -- luft nach innen
					},
					east = vector4(1687.02,3245.89,40.84, 282.11), --  nach aussen
				},
				south = {
					west = vector4(1121.88,3025.95,40.53, 104.8),
					east = vector4(1474.68,3121.03,40.53, 281.13),
				},
				small = {
					south = vector4(1405.99,3004.97,40.54, 130.22),
					north = vector4(1618.52,3220.07,40.42, 308.95),
				},
			},
			Destinations = {
				lsia = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				mcaf = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				cpa = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				usaf = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				tanker = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
			},
			Zone = "DESRT"
		},
		mcaf = {
			Name ='McKenzie Airfield',
			Ticket = vector3(2122.3, 4784.71, 40.97),
			PlaneSpawn = vector4(0,0,0,0),
			RunWayStart = vector3(0,0,0),
			RunWayEnd = vector3(0,0,0),
			TaskVehicleDriveToCoordLongrange = vector3(0,0,0),
			TaskPlaneMission = vector3(0,0,0),
			Runways = {
				main = {
					west = vector4(1954.98,4721.29,41.06,114.11),
					east = vector4(2125.65,4809.72,41.2,290.98),
				}
			},
			Destinations = {
				lsia = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				ssa = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				cpa = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				usaf = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				tanker = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
			},
			Zone = "GRAPE"
		},
		usaf = {
			Name ='Fort Zancuda Airfield',
			Ticket = vector3(0,0,0),
			PlaneSpawn = vector4(0,0,0,0),
			RunWayStart = vector3(0,0,0),
			RunWayEnd = vector3(0,0,0),
			TaskVehicleDriveToCoordLongrange = vector3(0,0,0),
			TaskPlaneMission = vector3(0,0,0),
			Runways = {
				main = {
					west = vector4(-2718.35,3269.12,32.81,57.23),
					east = vector4(-2055.03,2885.88,32.85,237.34),
				}
			},
			Destinations = {
				lsia = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				ssa = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				cpa = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				mcaf = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				tanker = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
			},
			Zone = ""
		},
		tanker = {
			Name ='Flugzeugträger',
			Ticket = vector3(0,0,0),
			PlaneSpawn = vector4(0,0,0,0),
			RunWayStart = vector3(0,0,0),
			RunWayEnd = vector3(0,0,0),
			TaskVehicleDriveToCoordLongrange = vector3(0,0,0),
			TaskPlaneMission = vector3(0,0,0),
			Runways = {
				main = {
					north = vector4(3009.18, -4616.18, 15.26, 26.26),
					south = vector4(3090.15, -4789.8, 15.26, 200.19),
				},
				short = {
					north = vector4(3013.92, -4525.25, 15.26, 11.85),
					south = vector4(3046.17, -4616.07, 15.26, 191.97),
				}
			},
			Destinations = {
				lsia = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				ssa = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				mcaf = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				usaf = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				cpa = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
			},
			Zone = ""
		},
		cpa = {
			Name ='Cayo Perico Island',
			Ticket = vector3(4464.59, -4476.53, 3.22),
			PlaneSpawn = vector4(4404.76, -4526.4, 4.18, 106.7817),
			RunWayStart = vector3(4009.69,-4670.94,4.18+1.0001),
			RunWayEnd = vector3(4274.53,-4574.21,4.18+1.0001),
			TaskVehicleDriveToCoordLongrange = vector3(4101.35,-4636.82,4.18),
			TaskPlaneMission = vector3(3526.92,-3951.51,117.74),
			Runways = {
				main = {
					west = vector4(4009.69, -4670.94, 4.18, 0),
					east = vector4(4404.76, -4526.4, 4.18, 106.7817),
				}
			},
			Destinations = {
				lsia = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				mcaf = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				ssa = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				usaf = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
				tanker = {
					Price = 250,
					Planes = { 'miljet' },
					Pilots = { 's_m_m_pilot_01' },
				},
			},
			Zone = "ISHEIST"
		}
	}
}
current = {
	flying = false,
	departure = nil,
	destination = nil,
	route = nil,
	landing = nil,
	pilot = nil,
	plane = nil,
	task = {
		name = nil,
		x = 0,
		y = 0,
		z = 0,
		h = 0,
	},
	blips = {},
}