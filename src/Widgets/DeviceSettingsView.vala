/* -*- Mode: Vala; indent-tabs-mode: nil; c-basic-offset: 4; tab-width: 4 -*- */
/*
 * DeviceSettingsList.vala
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 */

public class PantheonSoundControl.Widgets.DeviceSettingsView : Gtk.Grid {
    private DeviceSettingsList m_DevicesList;

    public unowned Manager manager { get; construct; }

    construct {
        orientation = Gtk.Orientation.HORIZONTAL;

        m_DevicesList = new DeviceSettingsList (manager);

        add (m_DevicesList);
        add (m_DevicesList.stack);
    }

    public DeviceSettingsView (Manager inManager) {
        GLib.Object (
            manager: inManager
        );
    }
}