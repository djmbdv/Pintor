using Gtk;
using Gdk;
using Cairo;
public class Lienzo:Gtk.DrawingArea{

    private int x {public get; public set;}
    private double center_x {set;get;default = 0;}
    private double center_y;
    private Point  p;
    private Surface surface;
    private Surface tool_surface;
    public Gdk.RGBA primary_color{public set;get;}
    public Gdk.RGBA secondary_color{public set;get;}
    private bool pressed;
    private int area_width;
    private int area_height;
    private Cairo.Context context;
    private double zoom;

    public Lienzo () {
        add_events (Gdk.EventMask.BUTTON_PRESS_MASK
                  | Gdk.EventMask.BUTTON_RELEASE_MASK
                  | Gdk.EventMask.POINTER_MOTION_MASK);
        set_size_request (600, 600);
        pressed = false;
        area_width = 500;
        area_height = 500;
        zoom  = 1;
        primary_color = {0,0,0,1};
        secondary_color = {0,0,0,1};
    }
    
    

    public override bool draw(Cairo.Context ct){
        tool_surface = ct.get_target();

            if(context != null){
            ct.set_operator (Cairo.Operator.OVER);
            ct.set_source_surface(context.get_target(), 1,1);
            ct.paint();
            }

            ct.set_source_surface(tool_surface,0,0);
            ct.rectangle (0, 0, area_width + 1, area_height + 1);
            ct.set_source_rgba(0,0,0,1);
            ct.set_line_width (1);
            ct.stroke();
            ct.set_source_rgb(356,0,0);
            ct.set_line_width (1);

            ct.set_source_rgb(200,200,0);
            ct.arc(center_x,center_y,5,0,360);
            ct.stroke();
            return true;
        }


        public override bool button_press_event(EventButton event){
            stdout.printf("press\n");
            pressed = true;
            if(surface == null)return true;
            p.x = (int) event.x;
            p.y = (int) event.y;
            stdout.printf("x=%d y=%d\n", p.x,p.y);

            context = new Cairo.Context(surface);

            context.set_source_rgb (0, 1, 1);
            context.arc(center_x,center_y,2,0,360);
            context.stroke();
           // context.paint();
            this.queue_draw_area(p.x -6,p.y-6,12,12);

            return true;
        }

        public override bool button_release_event(EventButton event){
            stdout.printf("release\n");
            pressed = false;

            return true;
        }
        public override bool configure_event(EventConfigure event){
           // stdout.printf("Event Configure\n");
              Gtk.Allocation allocation;
        this.get_allocation(out allocation);
       if(surface == null){
        this.surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, area_width, area_height);
        context = new Cairo.Context(surface);
        context.rectangle (0, 0, area_width, area_height);
        context.set_source_rgba(1,1,1,1);
        context.fill ();
        context.paint();
        }
            return true;
        }

        public override bool motion_notify_event (Gdk.EventMotion event) {
       //     if(( event.x - center_x).abs() + ( event.y - center_y).abs() > 1){

                if(pressed){
               //     stdout.printf("x=%d y=%d\n", center_x,center_y);

                    context = new Cairo.Context(surface);


                    context.move_to (center_x, center_y);
                    context.line_to ( event.x,event.y);
                      context.set_source_rgba (primary_color.red, primary_color.green, primary_color.blue,primary_color.alpha);
                    context.stroke();
                   // context.paint();
                //    this.queue_draw_area(center_x -6,center_y-6,12,12);
                }
                center_x = event.x;
                center_y = event.y;
                this.queue_draw();
              //  this.queue_draw_area(center_x -6,center_y-6,12,12);
           //}

            return true;
        }

}
