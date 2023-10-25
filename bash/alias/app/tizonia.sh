#!/bin/bash
# __tizonia__ __spotify__


# echo "||$SPOTIFY_USER||"
# echo "||$SPOTIFY_PASSWORD||"
tiz_art () {
    tizonia --spotify-user="$SPOTIFY_USER" --spotify-password="$SPOTIFY_PASSWORD" --spotify-artist="$@"
}

tiz_play () {
    tizonia --spotify-user="$SPOTIFY_USER" --spotify-password="$SPOTIFY_PASSWORD" --spotify-playlist="$@"
}

tiz_track () {
    tizonia --spotify-user="$SPOTIFY_USER" --spotify-password="$SPOTIFY_PASSWORD" --spotify-track="$@"
}

tiz_profesor_elemental () {
    tiz_art profesor elemental
}

