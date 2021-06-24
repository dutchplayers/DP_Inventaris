Config = {
	UseESX = true, -- if true, the player needs to pay for a ticket.
	ESXMenu = true, -- UseESX must set to true if you set his one to true.
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
			-- PlaneSpawn = { vector3(2123.71, 4806.34, 41.2), 110.19 },
			PlaneSpawn = { vector3(-1675.2446, -2798.8835, 14.5409), 327.8560 },
			RunWayStart = vector3(-1792.00122, -2882.29980, 13.9440+1.0001),
			RunWayEnd = vector3(-998.5266, -3341.3579, 13.9444+1.0001),
			TaskVehicleDriveToCoordLongrange = vector3(-1461.73,-2426.62,13.94),
			TaskPlaneMission = vector3(-1571.5589, -556.7288, 114.4482),
			PlayerDropOff = { vector3(-1042.0395, -2740.7780, 20.1692), 340.2285},
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
			},
			Zone = "AIRP"
		},
		ssa = {
			Name ='Sandy Shores',
			Ticket = vector3(1752.15, 3290.56, 41.11),
			PlaneSpawn = { vector3(1599.02453, 3231.2016, 40.4115), 105.7817 },
			RunWayStart = vector3(881.4462, 3060.4829, 41.1682+10.0001),
			RunWayEnd = vector3(1657.07, 3238.21, 40.5669+1.0001),
			TaskVehicleDriveToCoordLongrange = vector3(1403.0020751953, 2995.9179, 40.5507),
			TaskPlaneMission = vector3(-107.2212, 2717.5534, 61.9673),
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
			},
			Zone = "DESRT"
		},
		mcaf = {
			Name ='McKenzie Airfield',
			Ticket = vector3(2122.3, 4784.71, 40.97),
			PlaneSpawn = { vector3(0,0,0), 0 },
			RunWayStart = vector3(0,0,0),
			RunWayEnd = vector3(0,0,0),
			TaskVehicleDriveToCoordLongrange = vector3(0,0,0),
			TaskPlaneMission = vector3(0,0,0),
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
			},
			Zone = "GRAPE"
		},
		cpa = {
			Name ='Cayo Perico Island',
			Ticket = vector3(4464.59, -4476.53, 3.22),
			PlaneSpawn = { vector3(4404.76, -4526.4, 4.18), 106.7817 },
			RunWayStart = vector3(4009.69,-4670.94,4.18+1.0001),
			RunWayEnd = vector3(4274.53,-4574.21,4.18+1.0001),
			TaskVehicleDriveToCoordLongrange = vector3(4101.35,-4636.82,4.18),
			TaskPlaneMission = vector3(3526.92,-3951.51,117.74),
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
			},
			Zone = "ISHEIST"
		}
	}
}

current_departure = nil
current_destination = nil