<script>
    import Page from "./Page.svelte";
    export let classes = '';
</script>

<Page classes={classes}>
    <div class="centred vcenter">
        <slot />
    </div>
</Page>