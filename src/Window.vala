using Gtk;

public class Window : Gtk.ApplicationWindow {

		public Window (Gtk.Application app) {
            Object (
                application: app,
                icon_name: "com.github.djmbdv.pintor",
                resizable: true,
                title: "Pintor App",
                window_position: Gtk.WindowPosition.CENTER_ALWAYS
            );
		}

		construct{
            this.set_default_size(1000,600);
            var title = new Granite.Widgets.Welcome("Pintor", "App");
            Gtk.Paned  paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
            var lienzo = new Lienzo();
            var tools = new PanelTools(lienzo);

            tools.set_shadow_type(Gtk.ShadowType.ETCHED_IN);
            tools.set_size_request(200,-1);
            lienzo.set_size_request(600,-1);
            paned.pack1(tools,true,false);
            paned.pack2(lienzo,true,false);
            var gtk_settings = Gtk.Settings.get_default ();
            var mode_switch = new Granite.ModeSwitch.from_icon_name (
                "display-brightness-symbolic",
                "weather-clear-night-symbolic"
            );
            mode_switch.primary_icon_tooltip_text = ("Light background");
            mode_switch.secondary_icon_tooltip_text = ("Dark background");
            mode_switch.valign = Gtk.Align.CENTER;
            mode_switch.bind_property ("active", gtk_settings, "gtk_application_prefer_dark_theme");
            var headerbar = new Gtk.HeaderBar ();
            headerbar.get_style_context ().add_class ("default-decoration");
            headerbar.show_close_button = true;
            headerbar.pack_end (mode_switch);
            this.set_titlebar (headerbar);
            this.add(paned);
    }
}

