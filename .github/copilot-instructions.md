# AI Agent Instructions for elegso.site

## Project Overview
This is a **single-page marketing website** for ELEGSO (a legal practice specializing in arbitration and commercial disputes), built with **Astro 5** and **Tailwind CSS 4**. The site is primarily Russian-language focused with a modern dark theme.

## Architecture

### Core Structure
- **Pages**: Single entry point at `src/pages/index.astro` - routes to `/` only
- **Layout System**: `src/layouts/Layout.astro` wraps all pages with HTML structure, global styles, and base typography
- **Components**: Modular `.astro` components in `src/components/` - each represents a major section
  - `Header.astro` - Sticky navigation with dropdown menus (desktop nav with Tailwind groups)
  - `Hero.astro` - Landing section
  - `ServicesGrid.astro` - Service offerings display
  - `CasesSection.astro` - Case studies/portfolio
  - `HowWeWork.astro` - Process explanation
  - `LeadForm.astro` - Contact/inquiry form
  - `Footer.astro` - Footer with links/info
- **Styling**: Global CSS (`src/styles/global.css`) imports Tailwind; all styling uses Tailwind utility classes (no scoped CSS)

### Component Composition Pattern
The index page orchestrates section components in sequence:
```astro
<Layout>
  <Header />
  <main>
    <Hero />
    <ServicesGrid />
    {/* ... more sections ... */}
  </main>
  <Footer />
</Layout>
```

## Key Technical Details

### Dependencies & Build
- **Framework**: Astro 5.16.8 (static SSG by default)
- **Styling**: Tailwind CSS 4 with `@tailwindcss/vite` plugin (configured in `astro.config.mjs`)
- **Language**: TypeScript strict mode (`tsconfig.json` extends `astro/tsconfigs/strict`)
- **No JavaScript framework** (no React, Vue, Svelte) - pure Astro components

### Development Commands
```bash
npm run dev       # Start dev server at localhost:4321
npm run build     # Generate static site to ./dist/
npm run preview   # Preview built site locally
npm run astro     # Run Astro CLI commands
```

## Code Patterns & Conventions

### Component Structure (Astro)
- **Frontmatter section** (between `---`): Data, imports, server-only logic
- **HTML template**: Direct JSX-like syntax with `{variable}` interpolation
- Example from Header: Navigation arrays defined in frontmatter, then mapped in template with conditionals for dropdown menus
- **No client-side hydration** unless needed (Astro default: static HTML)

### Styling Approach
- **Tailwind-first**: All layout/spacing/colors use utility classes
- **Dark theme default**: Base classes `bg-slate-950 text-slate-100` on body
- **Color palette**: Primarily slate grays with accent colors (amber-300, sky-300) - see Header logo gradient
- **Responsive design**: Use Tailwind breakpoints (e.g., `hidden lg:flex` for desktop-only nav)

### Naming & Language
- **Component names**: PascalCase (e.g., `CasesSection.astro`)
- **Content language**: Russian (UI text, navigation labels, form placeholders)
- **Accessibility**: Include `aria-label` and semantic HTML attributes

## Common Developer Tasks

### Adding a New Section Component
1. Create `.astro` file in `src/components/`
2. Define section data/content in frontmatter
3. Build HTML template using Tailwind classes only
4. Import and add to `src/pages/index.astro` in desired order

### Modifying Navigation
- Edit `nav` array in `Header.astro` frontmatter
- Support nested `children` for dropdown menus
- Selector uses Tailwind group hover for dropdown styling

### Updating Styling
- **Global changes**: Modify `global.css` or component-level classes
- **Tailwind config**: Not exposed; use default Tailwind or update via `astro.config.mjs`
- **Color theming**: Centralized in component classes (e.g., gradient combinations in Header logo)

### Building for Production
- `npm run build` generates static HTML in `dist/`
- No server runtime needed - pure static site
- Deploy `dist/` folder to any static host

## Integration Points & Dependencies
- **No external APIs** in visible code (but LeadForm likely submits somewhere - check its implementation)
- **No databases or backend** - static site with optional form submission
- **External libraries**: Only Tailwind CSS for styling (no UI component libraries)

## Important Conventions
- **Astro file format**: `.astro` (not `.jsx` or `.tsx`) - special syntax combining frontmatter + HTML
- **Static-first mindset**: Default assumption is static HTML generation unless component needs interactivity
- **Utility-driven CSS**: Prefer Tailwind utilities over custom CSS classes
- **No CSS-in-JS**: All styles in Tailwind classes or `<style>` blocks within components

---
**Last updated**: January 2026 | **Astro version**: 5.16.8 | **Tailwind**: 4.1.18
