//: Star Trek - Playground solution


var characters: [String: String] = ["kirk": "TOS", "spock": "TOS", "picard": "TNG", "janeway": "VOY", "scotty": "TOS", "sisko": "DS9", "kira": "DS9", "chakotay": "VOY", "seven": "VOY", "dax": "DS9", "tuvok": "VOY", "tpol": "ENT", "riker": "TNG", "troi": "TNG"]

var series: [String: String] = ["TOS": "The Original Series", "TNG": "The Next Generation", "DS9": "Deep Space 9", "VOY": "Voyager", "ENT": "Enterprise", "DIS" : "Star Trek Discovery"]

var runtimes: [String: [Int]] = ["TOS": [1966, 1969], "TNG": [1987, 1994], "DS9": [1993, 1999], "VOY": [1995, 2001] , "ENT": [2001, 2004]]

var captains: [String: String] = ["kirk": "ncc1701", "sisko": "nx74205", "janeway": "ncc74656", "picard": "ncc1701d"]

var firstOfficers: [String] = ["spock", "kira", "chakotay", "riker", "tpol"]

var vulcans: [String] = ["spock", "tuvok", "tpol"]

var humans: [String] = ["sisko", "kirk", "picard", "chakotay", "janeway", "riker", "seven"]

var females: [String] = ["kira", "dax", "tpol", "janeway", "troi", "seven"]

var ships: [String: String] = ["ncc1701": "Enterprise", "nx74205": "Defiant", "ncc1701d": "Enterprise", "ncc74656": "Voyager", "nx01": "Enterprise"]

var defensive_power_rating: [String: String] = ["ncc1701": "100", "nx74205": "125", "ncc1701d": "140", "ncc74656": "135", "nx01": "75"]



// Create a comma-separated list of humans in alphabetical order
humans.sort(<)
var people = humans.sort(<).joinWithSeparator(", ")


// Create a Captain structure with name and ship as properties

struct Captain {
  var name: String
  var ship: String
  
  init(name: String, ship: String){
    self.name = name
    self.ship = ship
  }
}


// Create two comma-separated lists of ships -- one captained by men and the other by women
var arrayCaptains = captains.map{ Captain(name: $0, ship: $1) }
arrayCaptains
var maleCaptainedShips = arrayCaptains.filter{!females.contains($0.name)}.map{$0.ship}
var mList = maleCaptainedShips.joinWithSeparator(", ")
var femaleCaptainedShips = arrayCaptains.filter{females.contains($0.name)}.map{$0.ship}
var fList = femaleCaptainedShips.joinWithSeparator(", ")


// Get an aphlabetical list of the names of the ships captained by men and another by women
struct Ship {
  var registry: String
  var name: String
  
  init(registry: String, name: String){
    self.registry = registry
    self.name = name
  }
}

var mListShips = ships.map{ Ship(registry: $0, name: $1) }.filter{maleCaptainedShips.contains($0.registry)}.map{$0.name}
mListShips.sort(<)
var mList2 = mListShips.sort(<).joinWithSeparator(", ")

var fListShips = ships.map{ Ship(registry: $0, name: $1) }.filter{femaleCaptainedShips.contains($0.registry)}.map{$0.name}
fListShips.sort(<)
var fList2 = fListShips.joinWithSeparator(", ")


// Get the names of all series that had a vulcan character in it
struct Series {
  var short: String
  var name: String
  
  init(short: String, name: String){
    self.short = short
    self.name = name
  }
}


struct Character {
  var name: String
  var series: String
  
  init(name: String, series: String){
    self.name = name
    self.series = series
  }
}
var arraySeries = series.map{ Series(short: $0, name: $1) }
var arrayCharacters = characters.map{ Character(name: $0, series: $1) }

var vulcanCharacters = arrayCharacters.filter{vulcans.contains($0.name)}
vulcanCharacters
var seriesShortWithVulcans = vulcanCharacters.map{$0.series}
seriesShortWithVulcans
var seriesNameWithVulcans = arraySeries.filter{seriesShortWithVulcans.contains($0.short)}.map{$0.name}
seriesNameWithVulcans

// or the code golfing way and do it in one [hard-to-read] line...
var seriesWithVulcans = series.map{ Series(short: $0, name: $1) }.filter{characters.map{ Character(name: $0, series: $1) }.filter{vulcans.contains($0.name)}.map{$0.series}.contains($0.short)}.map{$0.name}
seriesWithVulcans


// Get the names of the first officers who were female
// (figured you needed a break with an easy one right about now...)
var femaleFirstOfficers = firstOfficers.filter{females.contains($0)}
femaleFirstOfficers


// Get the names of the first officers who were in a series that started before 2000

struct Runtime {
  var series: String
  var startYear: Int
  var endYear: Int
  
  init(series: String, started: Int, ended: Int){
    self.series = series
    self.startYear = started
    self.endYear = ended
  }
}

var arrayRuntimes = runtimes.map{ Runtime(series: $0, started: $1[0], ended: $1[1]) }
arrayRuntimes

var seriesBeforeY2K = arrayRuntimes.filter{ $0.startYear < 2000 }.map{$0.series}
seriesBeforeY2K

var charactersBeforeY2K = arrayCharacters.filter{seriesBeforeY2K.contains($0.series)}.map{$0.name}
charactersBeforeY2K

//var firstOfficersBeforeY2K = charactersBeforeY2K.filter{ firstOfficers.contains($0) }
//firstOfficersBeforeY2K.sort(<)

// again the code golfing way...
var firstOfficersBeforeY2K = characters.map{ Character(name: $0, series: $1) }.filter{runtimes.map{ Runtime(series: $0, started: $1[0], ended: $1[1]) }.filter{ $0.startYear < 2000 }.map{$0.series}.contains($0.series)}.map{$0.name}.filter{ firstOfficers.contains($0) }
firstOfficersBeforeY2K.sort(<)


// Find the human with the longest name and the Vulcan with the shortest one
let longest_human = humans.reduce("") { $1.characters.count > $0.characters.count ? $1 : $0 }
longest_human
let shortest_vulcan = vulcans.reduce("") { $0.characters.count > 0 ? ($1.characters.count < $0.characters.count ? $1 : $0) : $1 }
shortest_vulcan


// Find the first year of Star Trek (any series) and the last year of any Star Trek series
var years = runtimes.map{ $1 }
years
var allYears = years.flatten().sort
allYears().minElement()
allYears().maxElement()
allYears().first
allYears().last


// Find the cumulative defensive power rating of all the ships in the Federation fleet
let rio = Int("N/A")  // technically not right to say N/A as the Rio Grande does have some weaponry...
let defensivePowerInt = defensive_power_rating.map{ $1 }.flatMap{ Int($0) }
let defensivePowerTotal = defensivePowerInt.reduce(0, combine: +)

// or the code golfing way... (not so bad in this case, though)
let defensivePowerTotalCG = defensive_power_rating.map{ $1 }.flatMap{ Int($0) }.reduce(0, combine: +)
defensivePowerTotalCG
