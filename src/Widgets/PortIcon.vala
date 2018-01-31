/* -*- Mode: Vala; indent-tabs-mode: nil; c-basic-offset: 4; tab-width: 4 -*- */
/*
 * PortIcon.vala
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

public class PantheonSoundControl.Widgets.PortIcon : PantheonSoundControl.Widgets.Icon {
    private unowned Port m_Port;
    private GLib.Binding m_PortIconBind;
    private GLib.Binding m_PortSymbolBind;

    public unowned Port port {
        get {
            return m_Port;
        }
        set {
            if (m_Port != value) {
                if (m_Port != null) {
                    m_PortIconBind.unbind ();
                    m_PortSymbolBind.unbind ();
                }
                m_Port = value;
                if (m_Port != null) {
                    m_PortIconBind = m_Port.bind_property ("icon-name", m_Icon, "icon-name", GLib.BindingFlags.SYNC_CREATE,
                                                           on_port_icon_changed);
                    m_PortSymbolBind = m_Port.bind_property ("icon-name", m_Symbol, "icon-name", GLib.BindingFlags.SYNC_CREATE,
                                                             on_port_symbol_changed);
                } else {
                    if (use_symbolic) {
                        m_Icon.icon_name = "audio-card-symbolic";
                    } else {
                        m_Icon.icon_name = "audio-card";
                    }
                    m_Symbol.icon_name = "";
                    m_Symbol.hide ();
                }
            }
        }
    }

    public PortIcon (Port? inPort = null, Icon.Size inSize = Icon.Size.LARGE, bool inUseSymbolic = false) {
        GLib.Object (
            size: inSize,
            use_symbolic: inUseSymbolic,
            port: inPort
        );
    }

    private bool on_port_icon_changed (GLib.Binding inBind, GLib.Value inFrom, ref GLib.Value inoutTo) {
        string portIconName = (string)inFrom;
        string iconName = portIconName;

        switch (portIconName) {
            case "headset-output":
            case "headset-input":
                iconName = "audio-headset";
                break;

            case "phone-output":
            case "phone-input":
                iconName = "phone";
                break;

            default:
                break;
        }

        if (use_symbolic) {
            iconName += "-symbolic";
        }

        inoutTo.set_string (iconName);

        return true;
    }

    private bool on_port_symbol_changed (GLib.Binding inBind, GLib.Value inFrom, ref GLib.Value inoutTo) {
        string portIconName = (string)inFrom;
        string iconName = "";

        switch (portIconName) {
            case "headset-input":
            case "phone-input":
                iconName = "audio-input-microphone";
                m_Symbol.show ();
                break;

            case "video-display":
                if (m_Port.direction == Direction.OUTPUT) {
                    iconName = "audio-speakers";
                    m_Symbol.show ();
                } else if (m_Port.direction == Direction.INPUT) {
                    iconName = "audio-input-microphone";
                    m_Symbol.show ();
                } else {
                    m_Symbol.hide ();
                }
                break;

            default:
                m_Symbol.hide ();
                break;
        }

        if (use_symbolic) {
            iconName += "-symbolic";
        }

        inoutTo.set_string (iconName);

        return true;
    }
}