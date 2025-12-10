shader_type canvas_item;

uniform float speed : hint_range(0.0, 10.0) = 4.0;
uniform float strength : hint_range(0.0, 50.0) = 25.0;
uniform float tail_start : hint_range(0.0, 1.0) = 0.6;
uniform float dark_strength : hint_range(0.0, 1.0) = 0.35;

varying float sway_dir;

void vertex() {
    vec2 pos = VERTEX;

    float x = UV.x;
    float mask = smoothstep(tail_start, 1.0, x);

    float wave = sin(TIME * speed + UV.y * 8.0);

    sway_dir = wave;
    pos.x += wave * strength * mask;

    VERTEX = pos;
}

void fragment() {
    vec4 col = texture(TEXTURE, UV);

    // Bikin threshold supaya cuma ke kiri yang gelap
    float left_dark = smoothstep(0.0, -1.0, sway_dir);

    // Gelapkan dengan transisi halus
    col.rgb *= 1.0 - (left_dark * dark_strength);

    COLOR = col;
}
