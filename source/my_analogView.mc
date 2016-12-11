using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Math as Math;

module mySet {

	var myTEST = 30;


 }

module minuteXY {

	var myTEST = 30;
	var x0 = 0;
	var x1 = 0;
	var y0 = 0;
	var y1 = 0;

 }
 
 
module hourXY {

	var x0 = 0;
	var x1 = 0;
	var y0 = 0;
	var y1 = 0;

 }


class CustomMinuteBar extends Ui.Drawable {

	function draw(dc) {
		dc.drawLine(minuteXY.x0,minuteXY.y0,minuteXY.x1,minuteXY.y1);
	}

 }
 
class CustomHourBar extends Ui.Drawable {

	function draw(dc) {
		dc.drawLine(hourXY.x0,hourXY.y0,hourXY.x1,hourXY.y1);
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
	var ANGLE_ADJUST = Math.PI / 2.0;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        
        setLayout(Rez.Layouts.WatchFace(dc));
        
        hourXY.x0 = dc.getWidth() /2;
        hourXY.y0 = dc.getHeight() / 2;
        
        minuteXY.x0 = dc.getWidth() /2;
	    minuteXY.y0 = dc.getHeight() / 2;

        
        minute_radius = 7/8.0 * minuteXY.x0;
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
        
        var hour_fraction = minute / 60.0;
        var minute_angle = hour_fraction * TWO_PI;
        var hour_angle = ((hour % 12) / 12.0) * TWO_PI;
        minute_angle -= ANGLE_ADJUST;
        hour_angle -= ANGLE_ADJUST;
        
        
        view.setText(timeString);
        mySet.myTEST += 10;
        
        minuteXY.x1 = minuteXY.x0 + minute_radius * Math.cos(minute_angle);
        minuteXY.y1 = minuteXY.y0 + minute_radius * Math.sin(minute_angle);
        
        hourXY.x1 = hourXY.x0 + hour_radius * Math.cos(hour_angle);
        hourXY.y1 = hourXY.y0 + hour_radius * Math.sin(hour_angle);

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
