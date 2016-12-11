using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Math as Math;

module mySet {

	var myTEST = 30;
	var x0 = 0;
	var x1 = 0;
	var y0 = 0;
	var y1 = 0;

 }


class CustomMoveBar extends Ui.Drawable {

	function draw(dc) {
		dc.drawLine(mySet.x0,mySet.y0,mySet.x1,mySet.y1);
	}

 }

class my_analogView extends Ui.WatchFace {
 
	//coordinates for the center
	var center_x;
	var center_y;
	// the length of minute and hour hand
	var minute_radius;
	var hour_radius;
	
	var TWO_PI = Math.PI * 2;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        
        setLayout(Rez.Layouts.WatchFace(dc));
        center_x = dc.getWidth() /2;
        center_y = dc.getHeight() / 2;
        
        mySet.x0 = dc.getWidth() /2;
	    mySet.y0 = dc.getHeight() / 2;
	    mySet.y0 = 80;
	    mySet.y1 = 80;
        
        minute_radius = 7/8.0 * center_x;
        hour_radius = 2/3.0 * minute_radius;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel");
        var smile = View.findDrawableById("Smiley");
        var hour = clockTime.hour;
        var minute = clockTime.min;
        
        
        view.setText(timeString);
        mySet.myTEST += 10;
        mySet.x1 += 10;
        mySet.y1 += 10;

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        //dc.drawBitmap(0,0,background);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
