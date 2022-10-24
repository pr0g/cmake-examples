#include <SDL.h>

#include <cstdio>

int main(int argc, char** argv)
{
  if (SDL_Init(SDL_INIT_VIDEO) < 0) {
    printf("SDL could not initialize. SDL_Error: %s\n", SDL_GetError());
    return 1;
  }

  const int width = 800;
  const int height = 600;
  SDL_Window* window = SDL_CreateWindow(
    argv[0], SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, width, height,
    SDL_WINDOW_SHOWN);

  if (window == nullptr) {
    printf("Window could not be created. SDL_Error: %s\n", SDL_GetError());
    return 1;
  }

  SDL_Renderer* renderer = SDL_CreateRenderer(
    window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
  
  if (renderer == nullptr) {
    printf("Renderer could not be created. SDL_Error: %s\n", SDL_GetError());
    return 1;
  }

  for (bool running = true; running;) {
    for (SDL_Event currentEvent; SDL_PollEvent(&currentEvent) != 0;) {
      if (currentEvent.type == SDL_QUIT) {
        running = false;
        break;
      }
    }
    // cornflower blue
    SDL_SetRenderDrawColor(renderer, 100, 149, 237, 255);
    SDL_RenderClear(renderer);
    SDL_RenderPresent(renderer);
  }

  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);
  SDL_Quit();

  return 0;
}
