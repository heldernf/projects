local Config = {}

Config.locale = "es"

Config.charge = {
    -- TODO: remover cobrança do spawn e adicionar ao "parking"
    spawn = {
        account = "bank", -- bank | money | back_money
        amount = 2000,
    },
    impound = {
        account = "bank", -- bank | money | back_money
    },
    recover = {
        account = "bank", -- bank | money | back_money
        amount = 5000,
    }
}

Config.trackTime = 30000
Config.timeToAcceptOrDeclineVehicleTransfer = 10000

Config.blips = {
    garage = {
        name = "Garage",
        sprite = 357,
        size = 0.75,
        color = 17
    },
    impound = {
        name = "Impound",
        sprite = 357,
        size = 0.75,
        color = 3
    },
    track = {
        name = "Tracked Vehicle",
        sprite = 42,
        size = 0.75,
        color = 43
    }
}

Config.markers = {
    accessCar = {
        type = 27,
        upAndDownAnimation = false,
        faceCamera = false,
        rotate = false,
        color = { r = 128, g = 0, b = 155, a = 255 }
    },
    parkingCar = {
        type = 27,
        upAndDownAnimation = false,
        faceCamera = false,
        rotate = true,
        color = { r = 188, g = 0, b = 150, a = 255 }
    }
}

Config.depots = {
    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(213.64, -809.1, 31.01),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(220.11, -773.81, 30.8),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(220.11, -773.81, 30.8, 248.15),
        camera = {
            distance = 4.0,
            angle = -70.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(275.55, -344.8, 45.17),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(290.94, -337.96, 44.96),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(290.94, -337.96, 44.96, 158.72),
        camera = {
            distance = 4.0,
            angle = -70.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(-348.94, -874.65, 31.32),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(-320.12, -893.92, 31.07),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(-320.12, -893.92, 31.07, 349.52),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(100.42, -1073.24, 29.37),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(117.64, -1081.96, 29.22),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(117.64, -1081.96, 29.22, 7.73),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(15.12, -1727.92, 29.3),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(14.54, -1714.06, 29.3),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(14.54, -1714.06, 29.3, 200.78),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(-577.6, -1123.12, 22.38),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(-582.06, -1130.48, 22.18),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(-582.06, -1130.48, 22.18, 97.12),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(-796.02, -2023.44, 9.17),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(-775.9, -2024.95, 8.87),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(-775.9, -2024.95, 8.87, 222.17),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(903.56, -1575.55, 30.83),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(893.9, -1549.93, 30.6),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(893.9, -1549.93, 30.6, 224.28),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(-340.78, 266.69, 85.68),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(-340.78, 266.69, 85.68),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(-340.15, 286.89, 85.46, 281.62),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(362.26, 298.58, 103.88),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(374.85, 283.4, 103.18),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(374.85, 283.4, 103.18, 342.03),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(596.74, 91.5, 93.13),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(608.87, 103.71, 92.81),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(608.87, 103.71, 92.81, 76.14),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(-3030.9, 93.05, 12.35),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(-3030.65, 113.83, 11.61),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(-3030.65, 113.83, 11.61, 313.55),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(-703.5, 5790.1, 17.52),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(-707.62, 5783.67, 17.33),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(-707.62, 5783.67, 17.33, 151.22),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(83.85, 6420.52, 31.76),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(72.83, 6404.55, 31.23),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(72.83, 6404.55, 31.23, 135.23),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(1952.41, 3754.14, 32.21),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(1964.27, 3758.84, 32.23),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(1964.27, 3758.84, 32.23, 207.45),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },

    {
        vehicleType = "terrestrial",
        isImpound = false, -- IT'S DON'T WORK
        access = {
            center = vector3(2002.25, 3050.57, 47.21),
            size = 1.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -1.0
        },
        parking = {
            center = vector3(2010.73, 3056.23, 47.05),
            size = 4.0,
            viewDistance = 15.0,
            adjustMarkerPositionZ = -0.90
        },
        spawn = vector4(2010.73, 3056.23, 47.05, 56.74),
        camera = {
            distance = 4.0,
            angle = 30.0,
            aditionalHeight = 0.8
        },
    },
}

Config.debugZones = false

return Config