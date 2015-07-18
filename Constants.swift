//
//  Constants.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 5/5/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class Constants {
    
    struct URL {
        static let BASE = "http://localhost:3000/api/v1/" //"http://bac.colab.duke.edu:3000/api/v1/"
        static let GENERAL_TOURNAMENTS = BASE + "tournaments/general"
    }
    struct Identifier {
        static let UI_TABLE_VIEW_CELL = "UITableViewCell"
        static let ProfileCell = "ProfileCell"
        static let TournamentCell = "TournamentCell"
    }
    struct Location {
        static let City = "City"
        static let Sculpture = "Sculpture"
        static let Pin = "pin"
        static let Location = "location"
    }
    struct Credentials {
        static let Password = "password"
    }
    struct Date {
        static let GoogleCalendarFormat = "yyyy-MM-dd'T'HH:mm:ssSSSZZZZ"
        static let ReverseStandard = "yyyy-MM-dd"
        static let Standard = "MM-dd-yyyy "
    }
    struct Segue {
        static let Login = "login"
        static let Logout = "logout"
        static let SignUp = "signup"
        static let SpecificTournament = "specificTournament"
    }
    struct Color {
        static let ThemeBlue = UIColor(red: 34/255, green: 94/255, blue: 158/255, alpha: 1)
        static let BoarderColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
    }
    struct Cell {
        static let ProfileCellSize: CGFloat = 375.0
        static let TournamentCellSize: CGFloat = 80.0
    }
    struct Key {
        static let Description = "description"
        static let Summary = "summary"
        static let ID = "id"
        static let Start = "start"
        static let Register = "REGISTER"
        static let DateTime = "dateTime"
    }
    struct Image {
        static let ProfileBackground = "thebay.jpg"
    }
}