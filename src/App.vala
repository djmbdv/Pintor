/* main.vala
 *
 * Copyright 2020 David José Márquez Batiz
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Granite;

class App:Gtk.Application{
	construct {
        application_id = "com.github.djmbdv.pintor";
        flags = ApplicationFlags.FLAGS_NONE;
    }

	public Window window;

	public override void activate (){
        window = new Window(this);
		window.show_all ();
		if(window != null)
		add_window (window);
	}

	[CCode (instance_pos = -1)]
	public void on_destroy (Widget window){
		Gtk.main_quit();
	}
}


int main(string[] args){
    var app = new App ();
	app.run(args);
	return 0;
}
