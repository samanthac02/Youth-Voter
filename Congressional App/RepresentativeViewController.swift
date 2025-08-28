//
//  RepresentativeViewController.swift
//  Congressional App
//
//  Created by Samantha Chang on 10/24/21.
//

import UIKit
import CoreLocation

class RepresentativeViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var bar: UIView!
    @IBOutlet weak var bar2: UIView!
    @IBOutlet weak var bar3: UIView!
    
    @IBOutlet weak var representativeImage: UIImageView!
    @IBOutlet weak var representativeLabel: UILabel!
    @IBOutlet weak var representativeDescriptionLabel: UILabel!
    @IBOutlet weak var representativePhoneLabel: UILabel!
    @IBOutlet weak var representativeWebsiteLabel: UILabel!
    @IBOutlet weak var representativeTwitterLabel: UILabel!
    
    var representativeJSON = ""
    var representative: String = ""
    var representativeImageURL: String = ""
    var representativePhone: String = ""
    var representativeWebsite: String = ""
    var representativeActualWebsite: String = ""
    var representativeTwitter: String = ""
    
    @IBOutlet weak var senator1Label: UILabel!
    @IBOutlet weak var senator1Image: UIImageView!
    @IBOutlet weak var senator1DescriptionLabel: UILabel!
    @IBOutlet weak var senator1PhoneLabel: UILabel!
    @IBOutlet weak var senator1WebsiteLabel: UILabel!
    @IBOutlet weak var senator1TwitterLabel: UILabel!

    var senator1JSON = ""
    var senator1: String = ""
    var senator1ImageURL: String = ""
    var senator1Phone: String = ""
    var senator1Website: String = ""
    var senator1ActualWebsite: String = ""
    var senator1Twitter: String = ""
    
    @IBOutlet weak var senator2Label: UILabel!
    @IBOutlet weak var senator2Image: UIImageView!
    @IBOutlet weak var senator2DescriptionLabel: UILabel!
    @IBOutlet weak var senator2PhoneLabel: UILabel!
    @IBOutlet weak var senator2WebsiteLabel: UILabel!
    @IBOutlet weak var senator2TwitterLabel: UILabel!
    
    var senator2JSON = ""
    var senator2: String = ""
    var senator2ImageURL: String = ""
    var senator2Phone: String = ""
    var senator2Website: String = ""
    var senator2ActualWebsite: String = ""
    var senator2Twitter: String = ""
    
    // LONGITUDE AND LATITUDE HARDCODED COORDINATES
    let myLocation = CLLocation(latitude: 33.987869, longitude: -118.388908)
    var address: [String] = ["", "", "", "", "", ""]
    
    var locationManager: CLLocationManager!
    
    let congressAndImages: [ String ] = ["alma-adams/A000370", "robert-aderholt/A000055", "pete-aguilar/A000371", "rick-allen/A000372", "colin-allred/A000376", "mark-amodei/A000369", "kelly-armstrong/A000377", "jodey-arrington/A000375", "jake-auchincloss/A000148", "cynthia-axne/A000378", "brian-babin/B001291", "don-bacon/B001298", "james-baird/B001307", "troy-balderson/B001306", "tammy-baldwin/B001230", "jim-banks/B001299", "andy-barr/B001282", "nanette-diaz-barragan/B001300", "john-barrasso/B001261", "karen-bass/B001270", "joyce-beatty/B001281", "michael-bennet/B001267", "cliff-bentz/B000668", "ami-bera/B001287", "jack-bergman/B001301", "donald-beyer/B001292", "stephanie-bice/B000740", "andy-biggs/B001302", "gus-bilirakis/B001257", "dan-bishop/B001311", "sanford-bishop/B000490", "marsha-blackburn/B001243", "earl-blumenauer/B000574", "richard-blumenthal/B001277", "lisa-blunt-rochester/B001303", "roy-blunt/B000575", "lauren-boebert/B000825", "suzanne-bonamici/B001278", "cory-booker/B001288", "john-boozman/B001236", "mike-bost/B001295", "carolyn-bourdeaux/B001312", "jamaal-bowman/B001223", "brendan-boyle/B001296", "kevin-brady/B000755", "mike-braun/B001310", "mo-brooks/B001274", "anthony-brown/B001304", "sherrod-brown/B000944", "julia-brownley/B001285", "vern-buchanan/B001260", "ken-buck/B001297", "larry-bucshon/B001275", "ted-budd/B001305", "tim-burchett/B001309", "michael-burgess/B001248", "richard-burr/B001135", "cori-bush/B001224", "cheri-bustos/B001286", "g-k-butterfield/B001251", "ken-calvert/C000059", "kat-cammack/C001039", "maria-cantwell/C000127", "shelley-capito/C001047", "salud-carbajal/C001112", "ben-cardin/C000141", "jerry-carl/C001054", "thomas-carper/C000174", "andre-carson/C001072", "earl-carter/C001103", "john-carter/C001051", "troy-carter/C001125", "matt-cartwright/C001090", "ed-case/C001055", "bob-casey/C001070", "bob-casey/C001070", "bill-cassidy/C001075", "sean-casten/C001117", "kathy-castor/C001066", "joaquin-castro/C001091", "madison-cawthorn/C001104", "steve-chabot/C000266", "liz-cheney/C00110judy-chu/C001080", "david-cicilline/C001084", "katherine-clark/C001101", "yvette-clarke/C001067", "emanuel-cleaver/C001061", "ben-cline/C001118", "michael-cloud/C001115", "james-clyburn/C000537", "andrew-clyde/C001116", "steve-cohen/C001068", "tom-cole/C001053", "susan-collins/C001035", "james-comer/C001108", "gerald-connolly/C001078", "christopher-coons/C001088", "james-cooper/C000754", "john-cornyn/C001056", "j-correa/C001110", "catherine-cortez-masto/C001113", "jim-costa/C001059", "tom-cotton/C001095", "joe-courtney/C001069", "angie-craig/C001119", "kevin-cramer/C001096", "mike-crapo/C000880", "eric-crawford/C001087", "dan-crenshaw/C001120", "charlie-crist/C001111", "jason-crow/C001121", "ted-cruz/C001098", "henry-cuellar/C001063", "john-curtis/C001114", "tony-cardenas/C001097", "steve-daines/D000618", "sharice-davids/D000629", "warren-davidson/D000626", "danny-davis/D000096", "rodney-davis/D000619", "madeleine-dean/D000631", "peter-defazio/D000191", "diana-degette/D000197", "rosa-delauro/D000216", "suzan-delbene/D000617", "antonio-delgado/D000630", "val-demings/D000627", "mark-desaulnier/D000623", "scott-desjarlais/D000616", "theodore-deutch/D000610", "mario-diaz-balart/D000600", "debbie-dingell/D000624", "lloyd-doggett/D000399", "byron-donalds/D000032", "mike-doyle/D000482", "tammy-duckworth/D000622", "jeff-duncan/D000615", "neal-dunn/D000628", "richard-durbin/D000563", "jake-ellzey/E000071", "tom-emmer/E000294", "joni-ernst/E000295", "veronica-escobar/E000299", "anna-eshoo/E000215", "adriano-espaillat/E000297", "ron-estes/E000298", "dwight-evans/E000296", "pat-fallon/F000246", "randy-feenstra/F000446", "dianne-feinstein/F000062", "a-ferguson/F000465", "michelle-fischbach/F000470", "deb-fischer/F000463", "scott-fitzgerald/F000471", "brian-fitzpatrick/F000466", "charles-fleischmann/F000459", "lizzie-fletcher/F000468", "jeff-fortenberry/F000449", "bill-foster/F000454", "virginia-foxx/F000450", "lois-frankel/F000462", "c-franklin/F000472", "marcia-fudge/F000455", "russ-fulcher/F000469", "matt-gaetz/G000578", "mike-gallagher/G000579", "ruben-gallego/G000574", "john-garamendi/G000559", "andrew-garbarino/G000597", "jesus-garcia/G000586", "mike-garcia/G000061", "sylvia-garcia/G000587", "bob-gibbs/G000563", "kirsten-gillibrand/G000555", "carlos-gimenez/G000593", "louie-gohmert/G000552", "jared-golden/G000592", "jimmy-gomez/G000585", "tony-gonzales/G000594", "anthony-gonzalez/G000588", "vicente-gonzalez/G000581", "jenniffer-gonzalez-colon/G000582", "bob-good/G000595", "lance-gooden/G000589", "paul-gosar/G000565", "josh-gottheimer/G000583", "lindsey-graham/G000359", "kay-granger/G000377", "chuck-grassley/G000386", "garret-graves/G000577", "sam-graves/G000546", "al-green/G000553", "mark-green/G000590", "marjorie-greene/G000596", "h-griffith/G000568", "ral-grijalva/G000551", "glenn-grothman/G000576", "michael-guest/G000591", "brett-guthrie/G000558", "debra-haaland/H001080", "jim-hagedorn/H001088", "bill-hagerty/H000601", "josh-harder/H001090", "andy-harris/H001052", "kamala-harris/H001075", "diana-harshbarger/H001086", "vicky-hartzler/H001053", "maggie-hassan/H001076", "alcee-hastings/H000324", "josh-hawley/H001089", "jahana-hayes/H001081", "martin-heinrich/H001046", "kevin-hern/H001082", "yvette-herrell/H001084", "jaime-herrera-beutler/H001056", "jody-hice/H001071", "john-hickenlooper/H000273", "brian-higgins/H001038", "clay-higgins/H001077", "j-hill/H001072", "james-himes/H001047", "ashley-hinson/H001091", "mazie-hirono/H001042", "john-hoeven/H001061", "trey-hollingsworth/H001074", "steven-horsford/H001066", "chrissy-houlahan/H001085", "steny-hoyer/H000874", "richard-hudson/H001067", "jared-huffman/H001068", "bill-huizenga/H001058", "cindy-hyde-smith/H001079", "jim-inhofe/I000024", "darrell-issa/I000056", "sheila-jackson-lee/J000032", "ronny-jackson/J000304", "chris-jacobs/J000020", "sara-jacobs/J000305", "pramila-jayapal/J000298", "hakeem-jeffries/J000294", "bill-johnson/J000292", "dusty-johnson/J000301", "eddie-johnson/J000126", "henry-johnson/J000288", "mike-johnson/J000299", "ron-johnson/J000293", "mondaire-jones/J000306", "jim-jordan/J000289", "david-joyce/J000295", "john-joyce/J000302", "kaiali-i-kahele/K000396", "timothy-kaine/K000384", "marcy-kaptur/K000009", "john-katko/K000386", "william-keating/K000375", "fred-keller/K000395", "mark-kelly/K000377", "mike-kelly/K000376", "robin-kelly/K000385", "trent-kelly/K000388", "john-kennedy/K000393", "ro-khanna/K000389", "daniel-kildee/K000380", "derek-kilmer/K000381", "andy-kim/K000394", "young-kim/K000397", "ron-kind/K000188", "angus-king/K000383", "adam-kinzinger/K000378", "ann-kirkpatrick/K000368", "amy-klobuchar/K000367", "raja-krishnamoorthi/K000391", "ann-kuster/K000382", "david-kustoff/K000392", "darin-lahood/L000585", "doug-lamalfa/L000578", "conor-lamb/L000588", "doug-lamborn/L000564", "james-langevin/L000559", "james-lankford/L000575", "rick-larsen/L000560", "john-larson/L000557robert-latta/L000566", "jake-laturner/L000266", "brenda-lawrence/L000581", "al-lawson/L000586", "patrick-leahy/L000174", "barbara-lee/L000551", "mike-lee/L000577", "susie-lee/L000590", "teresa-leger-fernandez/L000273", "debbie-lesko/L000589", "julia-letlow/L000595", "andy-levin/L000592", "mike-levin/L000593", "ted-lieu/L000582", "kelly-loeffler/L000594", "zoe-lofgren/L000397", "billy-long/L000576", "barry-loudermilk/L000583", "alan-lowenthal/L000579", "frank-lucas/L000491", "blaine-luetkemeyer/L000569", "ben-lujan/L000570", "cynthia-lummis/L000571", "elaine-luria/L000591", "stephen-lynch/L000562", "nancy-mace/M000194", "tom-malinowski/M001203", "nicole-malliotakis/M000317", "carolyn-maloney/M000087", "sean-maloney/M001185", "joseph-manchin/M001183", "tracey-mann/M000871", "kathy-manning/M001135", "edward-markey/M000133", "roger-marshall/M001198", "thomas-massie/M001184", "brian-mast/M001199", "doris-matsui/M001163", "lucy-mcbath/M001208", "kevin-mccarthy/M001165", "michael-mccaul/M001157", "lisa-mcclain/M001136", "tom-mcclintock/M001177", "betty-mccollum/M001143", "mitch-mcconnell/M000355", "a-mceachin/M001200", "james-mcgovern/M000312", "patrick-mchenry/M001156", "david-mckinley/M001180", "cathy-rodgers/M001159", "jerry-mcnerney/M001166", "gregory-meeks/M001137", "peter-meijer/M001186", "robert-menendez/M000639", "grace-meng/M001188", "jeff-merkley/M001176", "daniel-meuser/M001204", "kweisi-mfume/M000687", "carol-miller/M001205", "mary-miller/M001211", "mariannette-miller-meeks/M001215", "john-moolenaar/M001194", "alexander-mooney/M001195", "barry-moore/M001212", "blake-moore/M001213", "gwen-moore/M001160", "jerry-moran/M000934", "joseph-morelle/M001206", "seth-moulton/M001196", "frank-mrvan/M001214", "markwayne-mullin/M001190", "lisa-murkowski/M001153", "christopher-murphy/M001169", "gregory-murphy/M001210", "stephanie-murphy/M001202", "patty-murray/M001111", "jerrold-nadler/N000002", "grace-napolitano/N000179", "richard-neal/N000015", "joe-neguse/N000191", "troy-nehls/N000026", "dan-newhouse/N000189", "marie-newman/N000192", "donald-norcross/N000188", "ralph-norman/N000190", "eleanor-norton/N000147", "devin-nunes/N000181", "tom-o-halleran/O000171", "jay-obernolte/O000019", "alexandria-ocasio-cortez/O000172", "ilhan-omar/O000173", "jon-ossoff/O000174", "burgess-owens/O000086", "alex-padilla/P000145", "steven-palazzo/P000601", "frank-pallone/P000034", "gary-palmer/P000609", "jimmy-panetta/P000613", "chris-pappas/P000614", "william-pascrell/P000096", "rand-paul/P000603", "donald-payne/P000604", "nancy-pelosi/P000197", "greg-pence/P000615", "ed-perlmutter/P000593", "scott-perry/P000605", "gary-peters/P000595", "scott-peters/P000608", "august-pfluger/P000048", "dean-phillips/P000616", "chellie-pingree/P000597", "stacey-plaskett/P000610", "mark-pocan/P000607", "katie-porter/P000618", "rob-portman/P000449", "bill-posey/P000599", "ayanna-pressley/P000617", "david-price/P000523", "mike-quigley/Q000023", "aumua-amata-radewagen/R000600", "jamie-raskin/R000606", "john-reed/R000122", "tom-reed/R000585", "guy-reschenthaler/R000610", "kathleen-rice/R000602", "tom-rice/R000597", "cedric-richmond/R000588", "james-risch/R000584", "harold-rogers/R000395", "mike-rogers/R000575", "mitt-romney/R000615", "john-rose/R000612", "jacky-rosen/R000608", "matthew-rosendale/R000103", "deborah-ross/R000305", "mike-rounds/R000605", "david-rouzer/R000603", "chip-roy/R000614", "lucille-roybal-allard/R000486", "marco-rubio/R000595", "raul-ruiz/R000599", "c-a-ruppersberger/R000576", "bobby-rush/R000515", "john-rutherford/R000609", "tim-ryan/R000577", "gregorio-sablan/S001177", "maria-salazar/S000168", "michael-san-nicolas/S001204", "bernard-sanders/S000033", "john-sarbanes/S001168", "ben-sasse/S001197", "steve-scalise/S001176", "mary-scanlon/S001205", "janice-schakowsky/S001145", "brian-schatz/S001194", "adam-schiff/S001150", "bradley-schneider/S001190", "kurt-schrader/S001180", "kim-schrier/S001216", "charles-schumer/S000148", "david-schweikert/S001183", "austin-scott/S001189", "david-scott/S001157", "rick-scott/S001217", "robert-scott/S000185", "tim-scott/S001184", "pete-sessions/S000250", "terri-sewell/S001185", "jeanne-shaheen/S001181", "richard-shelby/S000320", "brad-sherman/S000344", "mikie-sherrill/S001207", "michael-simpson/S001148", "kyrsten-sinema/S001191", "albio-sires/S001165", "elissa-slotkin/S001208", "adam-smith/S000510", "adrian-smith/S001172", "christopher-smith/S000522", "jason-smith/S001195", "tina-smith/S001203", "lloyd-smucker/S001199", "darren-soto/S001200", "abigail-spanberger/S001209", "victoria-spartz/S000929", "jackie-speier/S001175", "debbie-stabenow/S000770", "melanie-stansbury/S001218", "greg-stanton/S001211", "pete-stauber/S001212", "michelle-steel/S001135", "elise-stefanik/S001196", "bryan-steil/S001213", "w-steube/S001214", "haley-stevens/S001215", "chris-stewart/S001192", "steve-stivers/S001187", "marilyn-strickland/S001159", "dan-sullivan/S001198", "thomas-suozzi/S001201", "eric-swalwell/S001193", "linda-sanchez/S001156", "mark-takano/T000472", "van-taylor/T000479", "claudia-tenney/T000478", "jon-tester/T000464", "bennie-thompson/T000193", "glenn-thompson/T000467", "mike-thompson/T000460", "john-thune/T000250", "thomas-tiffany/T000165", "thom-tillis/T000476", "william-timmons/T000480", "dina-titus/T000468", "rashida-tlaib/T000481", "paul-tonko/T000469", "patrick-toomey/T000461", "norma-torres/T000474", "ritchie-torres/T000486", "lori-trahan/T000482", "david-trone/T000483", "tommy-tuberville/T000278", "michael-turner/T000463", "lauren-underwood/U000040", "fred-upton/U000031", "david-valadao/V000129", "jefferson-van-drew/V000133", "beth-van-duyne/V000134", "chris-van-hollen/V000128", "juan-vargas/V000130", "marc-veasey/V000131", "filemon-vela/V000132", "nydia-velazquez/V000081", "ann-wagner/W000812", "tim-walberg/W000798", "jackie-walorski/W000813", "michael-waltz/W000823", "mark-warner/W000805", "raphael-warnock/W000790", "elizabeth-warren/W000817", "debbie-wasserman-schultz/W000797", "maxine-waters/W000187", "bonnie-watson-coleman/W000822", "randy-weber/W000814", "daniel-webster/W000806", "peter-welch/W000800", "brad-wenstrup/W000815", "bruce-westerman/W000821", "jennifer-wexton/W000825", "sheldon-whitehouse/W000802", "roger-wicker/W000437", "susan-wild/W000826", "nikema-williams/W000788", "roger-williams/W000816", "frederica-wilson/W000808", "joe-wilson/W000795", "robert-wittman/W000804", "steve-womack/W000809", "ron-wright/W000827", "ron-wyden/W000779", "john-yarmuth/Y000062", "don-young/Y000033", "todd-young/Y000064", "lee-zeldin/Z000017"]
    let letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Bar top corners rounding
        bar.clipsToBounds = true
        bar.layer.cornerRadius = 16
        bar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        bar2.clipsToBounds = true
        bar2.layer.cornerRadius = 16
        bar2.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        bar3.clipsToBounds = true
        bar3.layer.cornerRadius = 16
        bar3.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        
        // Calls location and request functions
        self.determineCurrentLocation()
    }
    
    // MARK: Alert
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                self.representativeHttpRequestSecond()
                self.senatorHttpRequestSecond()

                print(self.representative)
                print(self.senator1)
                print(self.senator2)
                
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            switch action.style{
                case .default:
                print("default")

                case .cancel:
                print("cancel")
                
                if self.representative == "" {
                    self.sorryAlert(title: "Sorry, we can't find your represenative.", message: "Please try again later. Thank you!")
                } else {
                    self.representativeLabel.text = "\(self.representative)"
                    self.representativeDescriptionLabel.text = "U.S. House of Rep. for \(self.convertAbbreviationToState(for: self.address[3]))"
                    
                    DispatchQueue.global().async {
                        DispatchQueue.main.async {
                            var data = try? Data(contentsOf: URL(string: "https://www.uvu.edu/biology/research/heath_ogden/images/ogdenlab_default.jpg")!)
                            
                            if self.representativeImageURL == "" {
                                // Default Image
                                data = try? Data(contentsOf: URL(string: "https://www.uvu.edu/biology/research/heath_ogden/images/ogdenlab_default.jpg")!)
                            
                            // People who have weird pictures
                            } else if self.representative == "Don Bacon" {
                                data = try? Data(contentsOf: URL(string: "https://www.congress.gov/img/member/115_rp_ne_2_bacon_don_200.jpg")!)
                            } else if self.representative == "Karen Bass" {
                                data = try? Data(contentsOf: URL(string: "https://www.congress.gov/img/member/115_rp_ca_37_bass_karen_200.jpg")!)
                            } else if self.representative == "Ashley Hinson" || self.representative == "Beth Van Duyne" || self.representative == "Josh Harder" || self.representative == "Jimmy Gomez" || self.representative == "Jimmy Panetta" || self.representative == "Salud Carbajal" || self.representative == "Luis Correa" || self.representative == "Mark DeSaulnier" || self.representative == "David Valadao" || self.representative == "Jim Costa" || self.representative == "Linda Sanchez" || self.representative == "Adam Schiff" || self.representative == "Mike Thompson" || self.representative == "Barbara Lee" || self.representative == "Grace Napolitano" {
                                data = try? Data(contentsOf: URL(string: "https://www.uvu.edu/biology/research/heath_ogden/images/ogdenlab_default.jpg")!)
                            } else {
                                data = try? Data(contentsOf: URL(string: "https://www.congress.gov/img/member/\(self.representativeImageURL.lowercased())_200.jpg")!)
                            }
                            
                            self.representativeImage.image = UIImage(data: data!)
                        }
                    }
                    self.representativeImage.contentMode = .scaleAspectFill
                    
                    self.representativePhoneLabel.text = "\(self.representativePhone)"
                    self.representativeWebsiteLabel.text = "\(self.representativeWebsite)"
                    self.representativeTwitterLabel.text = "@\(self.representativeTwitter)"
                }
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func sorryAlert(title: String, message: String) {
        let sorryAlert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .alert)
        sorryAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(sorryAlert, animated: true, completion: nil)
    }
        
    // MARK: Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }

    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                alert(title: "No Access", message: "Please change the allow location preference in Settings so this app can get your representative information")
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                getAddressFromLatLon(Latitude: self.locationManager.location!.coordinate.latitude, Longitude: self.locationManager.location!.coordinate.longitude)
                
                //getAddressFromLatLon(Latitude: myLocation.coordinate.latitude, Longitude: myLocation.coordinate.longitude) //<= gets hardcoded location
                
                self.representativeHttpRequestFirst()
                self.senatorHttpRequestFirst()
                
                //let progressHUD = ProgressHUD(text: "Loading")
                //self.view.addSubview(progressHUD)

                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    /*self.representativeHttpRequestSecond()
                    self.senatorHttpRequestSecond()
                    progressHUD.hide()
                    
                    print("-----------")
                    print(self.representative)
                    print(self.senator1)
                    print(self.senator2)*/
                    
                    self.alert(title: "Dialog Box", message: "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address=\(self.address[2])%2C%20\(self.address[5])&includeOffices=true&levels=country&roles=headOfState&key=AIzaSyA8SsD1Rb-41aKVbBjL-a0U19OK0dpcfoU")
                }

            @unknown default:
            break
            }
        }
    }
    
    func getAddressFromLatLon(Latitude: Double, Longitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()


        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = Latitude
        center.longitude = Longitude

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]
                                        
                    if pm.subLocality != nil {
                        self.address[0] = pm.subLocality!.replacingOccurrences(of: " ", with: "%20")
                    }
                    if pm.thoroughfare != nil {
                        self.address[1] = pm.thoroughfare!.replacingOccurrences(of: " ", with: "%20")
                    }
                    if pm.locality != nil {
                        self.address[2] = pm.locality!.replacingOccurrences(of: " ", with: "%20")
                    }
                    if pm.administrativeArea != nil {
                        self.address[3] = pm.administrativeArea!.replacingOccurrences(of: " ", with: "%20")
                    }
                    if pm.country != nil {
                        self.address[4] = pm.country!.replacingOccurrences(of: " ", with: "%20")
                    }
                    if pm.postalCode != nil {
                        self.address[5] = pm.postalCode!.replacingOccurrences(of: " ", with: "%20")
                    }
                }
            
            print(self.address)
        })
    }
    
    // MARK: HTTP Requests
    func representativeHttpRequestFirst() {
        let session = URLSession.shared
        let url = URL(string: "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address=\(address[2])%2C%20\(address[5])&includeOffices=true&levels=country&roles=legislatorLowerBody&key=AIzaSyA8SsD1Rb-41aKVbBjL-a0U19OK0dpcfoU")!
        let group = DispatchGroup()
        group.enter()
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else { return }
            print(String(data: data, encoding: .utf8)!)
            group.leave()
        })
        task.resume()
        group.wait()
    }
    
    func representativeHttpRequestSecond() {
        let session = URLSession.shared
        let url = URL(string: "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address=\(address[2])%2C%20\(address[5])&includeOffices=true&levels=country&roles=legislatorLowerBody&key=AIzaSyA8SsD1Rb-41aKVbBjL-a0U19OK0dpcfoU")!
        //let url = URL(string: "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address=1000%20E%20Victoria%20Street%2C%20CA&includeOffices=true&levels=country&roles=legislatorLowerBody&key=AIzaSyA8SsD1Rb-41aKVbBjL-a0U19OK0dpcfoU")!
        //let url = URL(string: "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address=28058%20Braidwood%20Dr.%20Rancho%20Palos%20Verdes%2C%20CA%20&includeOffices=true&levels=country&roles=legislatorLowerBody&key=AIzaSyA8SsD1Rb-41aKVbBjL-a0U19OK0dpcfoU")!

       
        
        let group = DispatchGroup()
        group.enter()
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            self.representativeJSON = String(data: data, encoding: .utf8)!
            
            // Gets the representative
            let dict = self.convertStringToDictionary(text: self.representativeJSON)
            
            print(dict!["officials"])
            
            if dict!["officials"] != nil {
            
                // Formats the information of in the officials area
                var officials = String(describing: Array(arrayLiteral: dict!["officials"]!))
                officials = String(officials.dropLast())
                officials = String(officials.dropLast())
                officials = String(officials.dropLast())
                
                // Removes the unneeded characters in the beginning of the string
                for i in officials {
                    if i != "{" {
                        officials = String(officials.dropFirst())
                    } else {
                        break
                    }
                }

                // Separates the information into an array
                let officialsArray = Array(officials.components(separatedBy: ";"))
                
                // Finds the name of the official
                for officialInfo in officialsArray {
                    
                    if officialInfo.contains("name =") {
                        self.representative = officialInfo
                        
                        // Formats the representative information
                        self.representative = self.representative.replacingOccurrences(of: "name = ", with: "")
                        self.representative = self.representative.replacingOccurrences(of: "\"", with: "")
                        self.representative = self.representative.replacingOccurrences(of: "\\U00e1", with: "a")
                        
                        // Removes the spaces at the beginning of the string
                        for letter in self.representative {
                            if self.letters.contains(String(letter).lowercased()) == false {
                                self.representative = String(self.representative.dropFirst())
                            } else {
                                break
                            }
                        }
                        
                        print(officialsArray)
                        
                        if self.representative.contains(".") {
                            self.representative.remove(at: self.representative.index(self.representative.firstIndex(of: ".")!, offsetBy: -1))
                            self.representative.remove(at: self.representative.index(self.representative.firstIndex(of: ".")!, offsetBy: 1))
                            self.representative.remove(at: self.representative.firstIndex(of: ".")!)

                            
                            print(self.representative)
                        }
                    }
                    
                    if officialInfo.contains("phones = ") {
                        self.representativePhone = officialInfo.components(separatedBy: ",")[0]
                        
                        self.representativePhone = self.representativePhone.replacingOccurrences(of: " ", with: "")
                        self.representativePhone = self.representativePhone.replacingOccurrences(of: "\"", with: "")
                        self.representativePhone = self.representativePhone.replacingOccurrences(of: "-", with: "")
                        self.representativePhone = self.representativePhone.replacingOccurrences(of: "(", with: "")
                        self.representativePhone = self.representativePhone.replacingOccurrences(of: ")", with: "")
                        self.representativePhone = self.representativePhone.replacingOccurrences(of: "\n", with: "")
                        self.representativePhone = self.representativePhone.replacingOccurrences(of: "phones=", with: "")
                        
                        self.representativePhone.insert("(", at: self.representativePhone.startIndex)
                        self.representativePhone.insert(")", at: self.representativePhone.index(self.representativePhone.startIndex, offsetBy: 4))
                        self.representativePhone.insert(" ", at: self.representativePhone.index(self.representativePhone.startIndex, offsetBy: 5))
                        self.representativePhone.insert("-", at: self.representativePhone.index(self.representativePhone.startIndex, offsetBy: 9))
                    }
                    
                    if officialInfo.contains("urls = ") {
                        self.representativeWebsite = officialInfo.components(separatedBy: ",")[0]
                        
                        self.representativeWebsite = self.representativeWebsite.replacingOccurrences(of: " ", with: "")
                        self.representativeWebsite = self.representativeWebsite.replacingOccurrences(of: "(", with: "")
                        self.representativeWebsite = self.representativeWebsite.replacingOccurrences(of: "\"", with: "")
                        self.representativeWebsite = self.representativeWebsite.replacingOccurrences(of: "\n", with: "")
                        self.representativeWebsite = self.representativeWebsite.replacingOccurrences(of: "urls=", with: "")
                        
                        self.representativeActualWebsite = self.representativeWebsite
                        
                        self.representativeWebsite = self.representativeWebsite.replacingOccurrences(of: "https:", with: "")
                        self.representativeWebsite = self.representativeWebsite.replacingOccurrences(of: "/", with: "")
                        
                    }
                    
                    if officialInfo.contains("Twitter") {
                        self.representativeTwitter = officialsArray[officialsArray.index(before: (officialsArray.firstIndex(of: "\(officialInfo)")!))]
                        
                        self.representativeTwitter = self.representativeTwitter.replacingOccurrences(of: " ", with: "")
                        self.representativeTwitter = self.representativeTwitter.replacingOccurrences(of: "{", with: "")
                        self.representativeTwitter = self.representativeTwitter.replacingOccurrences(of: "}", with: "")
                        self.representativeTwitter = self.representativeTwitter.replacingOccurrences(of: ",", with: "")
                        self.representativeTwitter = self.representativeTwitter.replacingOccurrences(of: "\"", with: "")
                        self.representativeTwitter = self.representativeTwitter.replacingOccurrences(of: "\n", with: "")
                        self.representativeTwitter = self.representativeTwitter.replacingOccurrences(of: "id=", with: "")
                    }
                    
                    // Retrieves photo
                    for congresssPerson in 0..<self.congressAndImages.count {
                        if self.congressAndImages[congresssPerson].contains(self.representative.lowercased().replacingOccurrences(of: " ", with: "-")) {
                            self.representativeImageURL = self.congressAndImages[congresssPerson]
                            self.representativeImageURL = self.representativeImageURL.replacingOccurrences(of: "\(self.representative.lowercased().replacingOccurrences(of: " ", with: "-"))/", with: "")
                        }
                    }
                }
                
            } else {
                
                print("no")
                
            }

            group.leave()
            
        })
        task.resume()
        group.wait()
        
        // UI Stuff
        /*representativeLabel.text = "\(self.representative)"
        representativeDescriptionLabel.text = "U.S. House of Rep. for \(convertAbbreviationToState(for: address[3]))"
        
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                var data = try? Data(contentsOf: URL(string: "https://www.uvu.edu/biology/research/heath_ogden/images/ogdenlab_default.jpg")!)
                
                if self.representativeImageURL == "" {
                    // Default Image
                    data = try? Data(contentsOf: URL(string: "https://www.uvu.edu/biology/research/heath_ogden/images/ogdenlab_default.jpg")!)
                
                // People who have weird pictures
                } else if self.representative == "Don Bacon" {
                    data = try? Data(contentsOf: URL(string: "https://www.congress.gov/img/member/115_rp_ne_2_bacon_don_200.jpg")!)
                } else if self.representative == "Karen Bass" {
                    data = try? Data(contentsOf: URL(string: "https://www.congress.gov/img/member/115_rp_ca_37_bass_karen_200.jpg")!)
                } else if self.representative == "Ashley Hinson" || self.representative == "Beth Van Duyne" || self.representative == "Josh Harder" || self.representative == "Jimmy Gomez" || self.representative == "Jimmy Panetta" || self.representative == "Salud Carbajal" || self.representative == "Luis Correa" || self.representative == "Mark DeSaulnier" || self.representative == "David Valadao" || self.representative == "Jim Costa" || self.representative == "Linda Sanchez" || self.representative == "Adam Schiff" || self.representative == "Mike Thompson" || self.representative == "Barbara Lee" || self.representative == "Grace Napolitano" {
                    data = try? Data(contentsOf: URL(string: "https://www.uvu.edu/biology/research/heath_ogden/images/ogdenlab_default.jpg")!)
                } else {
                    data = try? Data(contentsOf: URL(string: "https://www.congress.gov/img/member/\(self.representativeImageURL.lowercased())_200.jpg")!)
                }
                
                self.representativeImage.image = UIImage(data: data!)
            }
        }
        representativeImage.contentMode = .scaleAspectFill
        
        representativePhoneLabel.text = "\(self.representativePhone)"
        representativeWebsiteLabel.text = "\(self.representativeWebsite)"
        representativeTwitterLabel.text = "@\(self.representativeTwitter)"*/
        
        self.alert(title: "\(self.representative)", message: "https://www.congress.gov/img/member/\(self.representativeImageURL.lowercased())_200.jpg")
    }
    
    func senatorHttpRequestFirst() {
        let session = URLSession.shared
        let url = URL(string: "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address=\(address[2])%2C%20\(address[5])&includeOffices=true&levels=country&roles=legislatorUpperBody&key=AIzaSyA8SsD1Rb-41aKVbBjL-a0U19OK0dpcfoU")!
        
        let group = DispatchGroup()
        group.enter()
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else { return }
            group.leave()
        })
        task.resume()
        group.wait()
    }
    
    func senatorHttpRequestSecond() {
        let session = URLSession.shared
        let url = URL(string: "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address=\(address[2])%2C%20\(address[5])&includeOffices=true&levels=country&roles=legislatorUpperBody&key=AIzaSyA8SsD1Rb-41aKVbBjL-a0U19OK0dpcfoU")!
        

        let group = DispatchGroup()
        group.enter()
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else { return }
            //print(String(data: data, encoding: .utf8)!)
            //print("==================================")
            
            // Gets the representative
            let dict = self.convertStringToDictionary(text: "\(String(data: data, encoding: .utf8)!)")
            
            if dict!["officials"] != nil {
                
                // Formats the information of in the officials area
                var officials = String(describing: Array(arrayLiteral: dict!["officials"]!))
                officials = String(officials.dropLast())
                officials = String(officials.dropLast())
                officials = String(officials.dropLast())

                // Removes the unneeded characters in the beginning of the string
                for i in officials {
                    if i != "{" {
                        officials = String(officials.dropFirst())
                    } else {
                        break
                    }
                }
                
                // Separates the information into an array
                let officialsArray = Array(officials.components(separatedBy: "address = "))
                
                for official in officialsArray {

                    let officialInfo = official.components(separatedBy: ";")
                    
                    for info in officialInfo {
                        if info.contains("name =") {
                            if (officialsArray.firstIndex(of: official)!) == 1 {
                                self.senator1 = info
                                
                                // Formats the representative information
                                self.senator1 = self.senator1.replacingOccurrences(of: "name =", with: "")
                                self.senator1 = self.senator1.replacingOccurrences(of: "\"", with: "")
                                self.senator1 = self.senator1.replacingOccurrences(of: "\\U00e1", with: "a")

                                for letter in self.senator1 {
                                    if self.letters.contains(String(letter).lowercased()) == false {
                                        self.senator1 = String(self.senator1.dropFirst())
                                    } else {
                                        break
                                    }
                                }
                                
                                if self.senator1.contains(".") {
                                    self.senator1.remove(at: self.senator1.index(self.senator1.firstIndex(of: ".")!, offsetBy: -1))
                                    self.senator1.remove(at: self.senator1.index(self.senator1.firstIndex(of: ".")!, offsetBy: 1))
                                    self.senator1.remove(at: self.senator1.firstIndex(of: ".")!)
                                    
                                    print(self.senator1)
                                }
                            }
                            
                            if (officialsArray.firstIndex(of: official)!) == 2 {
                                self.senator2 = info
                                self.senator2 = self.senator2.replacingOccurrences(of: "name =", with: "")
                                self.senator2 = self.senator2.replacingOccurrences(of: "\"", with: "")
                                self.senator1 = self.senator1.replacingOccurrences(of: "\\U00e1", with: "a")
                                
                                for letter in self.senator2 {
                                    if self.letters.contains(String(letter).lowercased()) == false {
                                        self.senator2 = String(self.senator2.dropFirst())
                                    } else {
                                        break
                                    }
                                }
                                
                                if self.senator2.contains(".") {
                                    self.senator2.remove(at: self.senator2.index(self.senator2.firstIndex(of: ".")!, offsetBy: -1))
                                    self.senator2.remove(at: self.senator2.index(self.senator2.firstIndex(of: ".")!, offsetBy: 1))
                                    self.senator2.remove(at: self.senator2.firstIndex(of: ".")!)
                                    
                                    print(self.senator2)
                                }
                            }
                            
                            if (officialsArray.firstIndex(of: official)!) == 1 {
                                self.senator1ImageURL = info
                            }
                            
                            if (officialsArray.firstIndex(of: official)!) == 2 {
                                self.senator2ImageURL = info
                            }
                            
                            // Grabs the image code from congressAndImages list
                            for congresssPerson in 0..<self.congressAndImages.count {
                                if self.congressAndImages[congresssPerson].contains(self.senator1.lowercased().replacingOccurrences(of: " ", with: "-")) {
                                    print(self.congressAndImages[congresssPerson].contains(self.senator1.lowercased().replacingOccurrences(of: " ", with: "-")))
                                    self.senator1ImageURL = self.congressAndImages[congresssPerson]
                                    self.senator1ImageURL = self.senator1ImageURL.replacingOccurrences(of: "\(self.senator1.lowercased().replacingOccurrences(of: " ", with: "-"))/", with: "")
                                    print(self.senator1ImageURL)
                                }
                                
                                if self.congressAndImages[congresssPerson].contains(self.senator2.lowercased().replacingOccurrences(of: " ", with: "-")) {
                                    self.senator2ImageURL = self.congressAndImages[congresssPerson]
                                    self.senator2ImageURL = self.senator2ImageURL.replacingOccurrences(of: "\(self.senator2.lowercased().replacingOccurrences(of: " ", with: "-"))/", with: "")
                                    print(self.senator2ImageURL)
                                }
                            }
                        }
                        
                        /*if info.contains("photoUrl =") {
                            if (officialsArray.firstIndex(of: official)!) == 1 {
                                self.senator1ImageURL = info
                            }
                            
                            if (officialsArray.firstIndex(of: official)!) == 2 {
                                self.senator2ImageURL = info
                            }
                            
                            // Grabs the image code from congressAndImages list
                            for congresssPerson in 0..<self.congressAndImages.count {
                                if self.congressAndImages[congresssPerson].contains(self.senator1.lowercased().replacingOccurrences(of: " ", with: "-")) {
                                    self.senator1ImageURL = self.congressAndImages[congresssPerson]
                                    self.senator1ImageURL = self.senator1ImageURL.replacingOccurrences(of: "\(self.senator1.lowercased().replacingOccurrences(of: " ", with: "-"))/", with: "")
                                    print(self.senator1ImageURL)
                                }
                                
                                if self.congressAndImages[congresssPerson].contains(self.senator2.lowercased().replacingOccurrences(of: " ", with: "-")) {
                                    self.senator2ImageURL = self.congressAndImages[congresssPerson]
                                    self.senator2ImageURL = self.senator2ImageURL.replacingOccurrences(of: "\(self.senator2.lowercased().replacingOccurrences(of: " ", with: "-"))/", with: "")
                                    print(self.senator2ImageURL)
                                }
                            }
                        }*/
                        
                        if info.contains("phones =") {
                            if (officialsArray.firstIndex(of: official)!) == 1 {
                                self.senator1Phone = info
                                
                                self.senator1Phone = self.senator1Phone.replacingOccurrences(of: " ", with: "")
                                self.senator1Phone = self.senator1Phone.replacingOccurrences(of: "\"", with: "")
                                self.senator1Phone = self.senator1Phone.replacingOccurrences(of: "-", with: "")
                                self.senator1Phone = self.senator1Phone.replacingOccurrences(of: "(", with: "")
                                self.senator1Phone = self.senator1Phone.replacingOccurrences(of: ")", with: "")
                                self.senator1Phone = self.senator1Phone.replacingOccurrences(of: "\n", with: "")
                                self.senator1Phone = self.senator1Phone.replacingOccurrences(of: "phones=", with: "")
                                
                                self.senator1Phone.insert("(", at: self.senator1Phone.startIndex)
                                self.senator1Phone.insert(")", at: self.senator1Phone.index(self.senator1Phone.startIndex, offsetBy: 4))
                                self.senator1Phone.insert(" ", at: self.senator1Phone.index(self.senator1Phone.startIndex, offsetBy: 5))
                                self.senator1Phone.insert("-", at: self.senator1Phone.index(self.senator1Phone.startIndex, offsetBy: 9))
                            }
                            
                            if (officialsArray.firstIndex(of: official)!) == 2 {
                                self.senator2Phone = info
                                
                                self.senator2Phone = self.senator2Phone.replacingOccurrences(of: " ", with: "")
                                self.senator2Phone = self.senator2Phone.replacingOccurrences(of: "\"", with: "")
                                self.senator2Phone = self.senator2Phone.replacingOccurrences(of: "-", with: "")
                                self.senator2Phone = self.senator2Phone.replacingOccurrences(of: "(", with: "")
                                self.senator2Phone = self.senator2Phone.replacingOccurrences(of: ")", with: "")
                                self.senator2Phone = self.senator2Phone.replacingOccurrences(of: "\n", with: "")
                                self.senator2Phone = self.senator2Phone.replacingOccurrences(of: "phones=", with: "")
                                
                                self.senator2Phone.insert("(", at: self.senator2Phone.startIndex)
                                self.senator2Phone.insert(")", at: self.senator2Phone.index(self.senator2Phone.startIndex, offsetBy: 4))
                                self.senator2Phone.insert(" ", at: self.senator2Phone.index(self.senator2Phone.startIndex, offsetBy: 5))
                                self.senator2Phone.insert("-", at: self.senator2Phone.index(self.senator2Phone.startIndex, offsetBy: 9))
                            }
                        }

                        if info.contains("urls =") {
                            if (officialsArray.firstIndex(of: official)!) == 1 {
                                self.senator1Website = info
                                
                                self.senator1Website = self.senator1Website.replacingOccurrences(of: " ", with: "")
                                self.senator1Website = self.senator1Website.replacingOccurrences(of: "(", with: "")
                                self.senator1Website = self.senator1Website.replacingOccurrences(of: "\"", with: "")
                                self.senator1Website = self.senator1Website.replacingOccurrences(of: "\n", with: "")
                                self.senator1Website = self.senator1Website.replacingOccurrences(of: "urls=", with: "")
                                self.senator1Website = Array(self.senator1Website.components(separatedBy: ","))[0]
                                
                                self.senator1ActualWebsite = self.senator1Website
                                
                                self.senator1Website = self.senator1Website.replacingOccurrences(of: "https:", with: "")
                                self.senator1Website = self.senator1Website.replacingOccurrences(of: "/", with: "")
                            }
                            
                            if (officialsArray.firstIndex(of: official)!) == 2 {
                                self.senator2Website = info
                                
                                self.senator2Website = self.senator2Website.replacingOccurrences(of: " ", with: "")
                                self.senator2Website = self.senator2Website.replacingOccurrences(of: "(", with: "")
                                self.senator2Website = self.senator2Website.replacingOccurrences(of: "\"", with: "")
                                self.senator2Website = self.senator2Website.replacingOccurrences(of: "\n", with: "")
                                self.senator2Website = self.senator2Website.replacingOccurrences(of: "urls=", with: "")
                                self.senator2Website = Array(self.senator2Website.components(separatedBy: ","))[0]
                                
                                self.senator2ActualWebsite = self.senator2Website
                                
                                self.senator2Website = self.senator2Website.replacingOccurrences(of: "https:", with: "")
                                self.senator2Website = self.senator2Website.replacingOccurrences(of: "/", with: "")
                            }
                        }

                        
                        if info.contains("Twitter") {
                            if (officialsArray.firstIndex(of: official)!) == 1 {
                                let officialArray = official.replacingOccurrences(of: " ", with: "").components(separatedBy: ";")
                                print(officialArray)

                                let twitterIndex = officialArray.firstIndex(of: info.replacingOccurrences(of: " ", with: ""))!
                                print(twitterIndex)
                                
                                self.senator1Twitter = officialArray[twitterIndex - 1]
                                self.senator1Twitter = self.senator1Twitter.replacingOccurrences(of: " ", with: "")
                                self.senator1Twitter = self.senator1Twitter.replacingOccurrences(of: "{", with: "")
                                self.senator1Twitter = self.senator1Twitter.replacingOccurrences(of: "}", with: "")
                                self.senator1Twitter = self.senator1Twitter.replacingOccurrences(of: ",", with: "")
                                self.senator1Twitter = self.senator1Twitter.replacingOccurrences(of: "\"", with: "")
                                self.senator1Twitter = self.senator1Twitter.replacingOccurrences(of: "\n", with: "")
                                self.senator1Twitter = self.senator1Twitter.replacingOccurrences(of: "id=", with: "")
                                
                                print(self.senator1Twitter)
                            }
                            
                            if (officialsArray.firstIndex(of: official)!) == 2 {
                                let officialArray = official.replacingOccurrences(of: " ", with: "").components(separatedBy: ";")
                                print(officialArray)

                                let twitterIndex = officialArray.firstIndex(of: info.replacingOccurrences(of: " ", with: ""))!
                                print(twitterIndex)
                                
                                self.senator2Twitter = officialArray[twitterIndex - 1]
                                self.senator2Twitter = self.senator2Twitter.replacingOccurrences(of: " ", with: "")
                                self.senator2Twitter = self.senator2Twitter.replacingOccurrences(of: "{", with: "")
                                self.senator2Twitter = self.senator2Twitter.replacingOccurrences(of: "}", with: "")
                                self.senator2Twitter = self.senator2Twitter.replacingOccurrences(of: ",", with: "")
                                self.senator2Twitter = self.senator2Twitter.replacingOccurrences(of: "\"", with: "")
                                self.senator2Twitter = self.senator2Twitter.replacingOccurrences(of: "\n", with: "")
                                self.senator2Twitter = self.senator2Twitter.replacingOccurrences(of: "id=", with: "")
                                
                                print(self.senator2Twitter)
                            }
                        }

                    }
                }
            } else {
                print("no aswell")
            }
            group.leave()
        })
        task.resume()
        group.wait()
        
        if self.senator1 != "" {
            // UI Stuff
            senator1Label.text = "\(self.senator1)"
            senator1DescriptionLabel.text = "U.S. Senator for \(convertAbbreviationToState(for: address[3]))"

            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    var data = try? Data(contentsOf: URL(string: "https://www.uvu.edu/biology/research/heath_ogden/images/ogdenlab_default.jpg")!)
                    
                    if self.senator1ImageURL == "" {
                        // Default Image
                        data = try? Data(contentsOf: URL(string: "https://www.uvu.edu/biology/research/heath_ogden/images/ogdenlab_default.jpg")!)

                    } else {
                        data = try? Data(contentsOf: URL(string: "https://www.congress.gov/img/member/\(self.senator1ImageURL.lowercased())_200.jpg")!)
                    }
                    
                    self.senator1Image.image = UIImage(data: data!)
                }
            }
            senator1Image.contentMode = .scaleAspectFill
            
            senator1PhoneLabel.text = "\(self.senator1Phone)"
            senator1WebsiteLabel.text = "\(self.senator1Website)"
            senator1TwitterLabel.text = "@\(self.senator1Twitter)"
            
            senator2Label.text = "\(self.senator2)"
            senator2DescriptionLabel.text = "U.S. Senator for \(convertAbbreviationToState(for: address[3]))"
            
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    var data = try? Data(contentsOf: URL(string: "https://www.uvu.edu/biology/research/heath_ogden/images/ogdenlab_default.jpg")!)
                    
                    if self.senator2ImageURL == "" {
                        // Default Image
                        data = try? Data(contentsOf: URL(string: "https://www.uvu.edu/biology/research/heath_ogden/images/ogdenlab_default.jpg")!)

                    } else {
                        data = try? Data(contentsOf: URL(string: "https://www.congress.gov/img/member/\(self.senator2ImageURL.lowercased())_200.jpg")!)
                    }
                    
                    self.senator2Image.image = UIImage(data: data!)
                }
            }
            senator2Image.contentMode = .scaleAspectFill
            
            senator2PhoneLabel.text = "\(self.senator2Phone)"
            senator2WebsiteLabel.text = "\(self.senator2Website)"
            senator2TwitterLabel.text = "@\(self.senator2Twitter)"
        }
    }
    
    // Converts the JSON to a dictionary
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
       if let data = text.data(using: .utf8) {
           do {
               let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
               return json
           } catch {
               print("Something went wrong")
           }
       }
       return nil
    }
    
    func convertAbbreviationToState(for state: String) -> String {
        let states = ["AL":"Alabama","AK":"Alaska","AZ":"Arizona","AR":"Arkansas", "CA":"California","CO":"Colorado","CT":"Connecticut", "DE":"Delaware","FL":"Florida", "GA":"Georgia","HI":"Hawaii", "ID":"Idaho","IL":"Illinois","IN":"Indiana","IA":"Iowa","KS":"Kansas","KY":"Kentucky","LA":"Louisiana","ME":"Maine","MD":"Maryland","MA":"Massachusetts","MI":"Michigan","MN":"Minnesota","MS":"Mississippi","MO":"Missouri","MT":"Montana","NE":"Nebraska","NV":"Nevada","NH":"New Hampshire","NJ":"New Jersey","NM":"New Mexico","NY":"New York","NC":"North Carolina","ND":"North Dakota","OH":"Ohio","OK":"Oklahoma","OR":"Oregon","PA":"Pennsylvania","RI":"Rhode Island","SC":"South Carolina","SD":"South Dakota","TN":"Tennessee","TX":"Texas","UT":"Utah","VT":"Vermont","VA":"Virginia","WA":"Washington","WV":"West Virginia","WI":"Wisconsin","WY":"Wyoming","DC":"District of Columbia","AS":"American Samoa","GU":"Guam","MP":"Northern Mariana Islands","PR":"Puerto Rico","UM":"United States Minor Outlying Islands","VI":"U.S. Virgin Islands"]
        
        return states[state]!
    }
    
    
    @IBAction func representativePhoneTapped(_ sender: Any) {
        var phone = representativePhone.replacingOccurrences(of: " ", with: "")
        phone = representativePhone.replacingOccurrences(of: "(", with: "")
        phone = representativePhone.replacingOccurrences(of: ")", with: "")
        phone = representativePhone.replacingOccurrences(of: "-", with: "")
        
        guard let number = URL(string: "tel://" + "\(phone)") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func representativeWebsiteTapped(_ sender: Any) {
        guard let url = URL(string: representativeActualWebsite) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func representativeTwitterTapped(_ sender: Any) {
        guard let url = URL(string: "https://twitter.com/\(representativeTwitter.lowercased())") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func senator1PhoneTapped(_ sender: Any) {
        var phone = senator1Phone.replacingOccurrences(of: " ", with: "")
        phone = senator1Phone.replacingOccurrences(of: "(", with: "")
        phone = senator1Phone.replacingOccurrences(of: ")", with: "")
        phone = senator1Phone.replacingOccurrences(of: "-", with: "")
        
        guard let number = URL(string: "tel://" + "\(phone)") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func senator1WebsiteTapped(_ sender: Any) {
        guard let url = URL(string: senator1ActualWebsite) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func senator1TwitterTapped(_ sender: Any) {
        guard let url = URL(string: "https://twitter.com/\(senator1Twitter.lowercased())") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func senator2PhoneTapped(_ sender: Any) {
        var phone = senator2Phone.replacingOccurrences(of: " ", with: "")
        phone = senator2Phone.replacingOccurrences(of: "(", with: "")
        phone = senator2Phone.replacingOccurrences(of: ")", with: "")
        phone = senator2Phone.replacingOccurrences(of: "-", with: "")
        
        guard let number = URL(string: "tel://" + "\(senator2Phone)") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func senator2WebsiteTapped(_ sender: Any) {
        guard let url = URL(string: senator2ActualWebsite) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func senator2TwitterTapped(_ sender: Any) {
        guard let url = URL(string: "https://twitter.com/\(senator2Twitter.lowercased())") else { return }
        UIApplication.shared.open(url)
    }
}

class ProgressHUD: UIVisualEffectView {

    var text: String? {
        didSet {
            label.text = text
        }
    }

    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView

    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }

  func setup() {
    contentView.addSubview(vibrancyView)
    contentView.addSubview(activityIndictor)
    contentView.addSubview(label)
    activityIndictor.startAnimating()
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    if let superview = self.superview {

      let width = superview.frame.size.width / 2.3
      let height: CGFloat = 50.0
      self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                      y: superview.frame.height / 2 - height / 2,
                      width: width,
                      height: height)
      vibrancyView.frame = self.bounds

      let activityIndicatorSize: CGFloat = 40
      activityIndictor.frame = CGRect(x: 5,
                                      y: height / 2 - activityIndicatorSize / 2,
                                      width: activityIndicatorSize,
                                      height: activityIndicatorSize)

      layer.cornerRadius = 8.0
      layer.masksToBounds = true
      label.text = text
      label.textAlignment = NSTextAlignment.center
      label.frame = CGRect(x: activityIndicatorSize + 5,
                           y: 0,
                           width: width - activityIndicatorSize - 15,
                           height: height)
      label.textColor = UIColor.gray
      label.font = UIFont.boldSystemFont(ofSize: 16)
    }
  }

  func show() {
    self.isHidden = false
  }

  func hide() {
    self.isHidden = true
  }
}
