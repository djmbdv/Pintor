using Gtk;




class PanelTools:Gtk.Frame{
    public Lienzo lienzo{ get; construct set;}


    private ColorButton color_primary;
    private ColorButton color_secondary;


     public void set_colors (ColorButton b){
          if(b == color_primary)lienzo.primary_color = b.get_rgba();
          else lienzo.secondary_color = b.get_rgba();
    }
    public PanelTools(Lienzo lienzo){

        this.lienzo = lienzo;
        Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

		Gtk.ToolPalette tools_palette = new Gtk.ToolPalette();
		var group = new  Gtk.ToolItemGroup(_("Grupo"));
		group.set_collapsed(false);
		tools_palette.add(group);
		var item =  new  Gtk.ToolButton(null,_("_Open") ) ;
		item.set_icon_name("document-open");
        group.insert(item,-1);
        color_primary = new ColorButton();


        color_secondary = new ColorButton();


        box.pack_start(tools_palette);
        box.pack_start(new Label(_("Primary Color e")),false);
        box.pack_start(color_primary, false);
        box.pack_start(new Label(_("Secondary Color")),false);
        box.pack_start(color_secondary, false);
		this.add (box);
		color_secondary.set_rgba({1,1,1,1});
		color_primary.set_rgba({0,0,0,1});
		color_primary.color_set.connect(set_colors);
		color_secondary.color_set.connect(set_colors );
		this.queue_draw();
    }

}
