pragma Singleton
import QtQuick 2.2


Item {

    property alias applications: app_group
    property alias types: types_group
    property alias spinners: spinner_group
    property alias controls: control_group
    property alias editor: editor_group
    property alias directional: directional_group
    property alias player: player_group
    property alias brand: brand_group
    property alias medical: medical_group

    QtObject {
        id: app_group
        readonly property string adjust: "\uf042"
        readonly property string anchor: "\uf13d"
        readonly property string archive: "f187"
        readonly property string arrows: "f047"
        readonly property string arrows_h: "f07e"
        readonly property string arrows_v: "f07d"
        readonly property string asterisk: "f069"
        readonly property string car: "f1b9"
        readonly property string ban: "f05e"
        readonly property string university: "f19c"
        readonly property string bar_chart_o: "f080"
        readonly property string barcode: "f02a"
        readonly property string bars: "f0c9"
        readonly property string beer: "f0fc"
        readonly property string bell: "f0f3"
        readonly property string bell_o: "f0a2"
        readonly property string bolt: "f0e7"
        readonly property string bomb: "f1e2"
        readonly property string book: "f02d"
        readonly property string bookmark: "f02e"
        readonly property string building: "f1ad"
        readonly property string building_o: "f0f7"
        readonly property string bug: "f188"
        readonly property string briefcase: "f0b1"
        readonly property string bookmark_o: "f097"
        readonly property string bullhorn: "f0a1"
        readonly property string bullseye: "f140"
        readonly property string taxi: "f1ba"
        readonly property string camera_retro: "f083"
        readonly property string camera: "f030"
        readonly property string calendar_o: "f133"
        readonly property string calendar: "f073"
        readonly property string caret_square_o_down: "f150"
        readonly property string caret_square_o_up: "f151"
        readonly property string caret_square_o_left: "f191"
        readonly property string caret_square_o_right: "f152"
        readonly property string check_circle: "f058"
        readonly property string check: "f00c"
        readonly property string certificate: "f0a3"
        readonly property string check_circle_o: "f05d"
        readonly property string check_square: "f14a"
        readonly property string check_square_o: "f046"
        readonly property string child: "f1ae"
        readonly property string circle: "f111"
        readonly property string circle_o: "f10c"
        readonly property string circle_o_notch: "f1ce"
        readonly property string circle_thin: "f1db"
        readonly property string clock_o: "f017"
        readonly property string cloud: "f0c2"
        readonly property string cloud_download: "f0ed"
        readonly property string cloud_upload: "f0ee"
        readonly property string code: "f121"
        readonly property string code_fork: "f126"
        readonly property string coffee: "f0f4"
        readonly property string cog: "f013"
        readonly property string cogs: "\uf085"
        readonly property string comment: "f075"
        readonly property string comment_o: "f0e5"
        readonly property string comments: "f086"
        readonly property string comments_o: "f0e6"
        readonly property string compass: "f14e"
        readonly property string credit_card: "f09d"
        readonly property string crop: "f125"
        readonly property string crosshairs: "f05b"
        readonly property string cube: "f1b2"
        readonly property string cubes: "f1b3"
        readonly property string cutlery: "f0f5"
        readonly property string tachometer: "f0e4"
        readonly property string database: "f1c0"
        readonly property string desktop: "f108"
        readonly property string dot_circle_o: "f192"
        readonly property string download: "f019"
        readonly property string pencil_square_o: "f044"
        readonly property string ellipsis_h: "f141"
        readonly property string ellipsis_v: "f142"
        readonly property string envelope: "f0e0"
        readonly property string envelope_o: "f003"
        readonly property string envelope_square: "f199"
        readonly property string eraser: "f12d"
        readonly property string exchange: "f0ec"
        readonly property string exclamation: "f12a"
        readonly property string exclamation_circle: "f06a"
        readonly property string exclamation_triangle: "f071"
        readonly property string external_link: "f08e"
        readonly property string external_link_square: "f14c"
        readonly property string eye: "f06e"
        readonly property string eye_slash: "f070"
        readonly property string fax: "f1ac"
        readonly property string female: "f182"
        readonly property string fighter_jet: "f0fb"
        readonly property string file_archive_o: "f1c6"
        readonly property string file_audio_o: "f1c7"
        readonly property string file_code_o: "f1c9"
        readonly property string file_excel_o: "f1c3"
        readonly property string file_image_o: "f1c5"
        readonly property string file_video_o: "f1c8"
        readonly property string file_pdf_o: "f1c1"
        readonly property string file_powerpoint_o: "f1c4"
        readonly property string file_word_o: "f1c2"
        readonly property string film: "f008"
        readonly property string filter: "f0b0"
        readonly property string fire: "f06d"
        readonly property string fire_extinguisher: "f134"
        readonly property string flag: "f024"
        readonly property string flag_checkered: "f11e"
        readonly property string flag_o: "f11d"
        readonly property string flash: "f0e7"
        readonly property string flask: "f0c3"
        readonly property string folder: "f07b"
        readonly property string folder_o: "f114"
        readonly property string folder_open: "f07c"
        readonly property string folder_open_o: "f115"
        readonly property string frown_o: "f119"
        readonly property string gamepad: "f11b"
        readonly property string gavel: "f0e3"
        readonly property string gift: "f06b"
        readonly property string glass: "f000"
        readonly property string globe: "f0ac"
        readonly property string graduation_cap: "f19d"
        readonly property string users: "f0c0"
        readonly property string hdd_o: "f0a0"
        readonly property string headphones: "f025"
        readonly property string heart: "f004"
        readonly property string heart_o: "f08a"
        readonly property string history: "f1da"
        readonly property string home: "f015"
        readonly property string picture_o: "f03e"
        readonly property string inbox: "f01c"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"
//        readonly property string cogs: "\uf085"






//        readonly property string cogs: "\uf085"
//        readonly property alias cog: spinner_group.cog
        readonly property alias refresh: spinner_group.refresh
    }

    QtObject {
        id: types_group
    }

    QtObject {
        id: spinner_group
        readonly property string cog: "\uf013"
        readonly property string cogs: "\uf085"
        readonly property string refresh: "\uf021"
    }

    QtObject {
        id: control_group
    }

    QtObject {
        id: editor_group
    }

    QtObject {
        id: directional_group
    }

    QtObject {
        id: player_group
    }

    QtObject {
        id: brand_group
    }

    QtObject {
        id: medical_group
    }
}
