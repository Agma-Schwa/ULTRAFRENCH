<script lang="ts">
    import "$lib/style.scss"

    export let classes = '';
    export let title = '';
</script>

<style lang="scss">
    .page {
        position: relative;
        scroll-snap-align: start;
        aspect-ratio: 16 / 9;
        width: 16cm;
        height: 9cm;
        margin: 0;
        box-shadow: inset 0 0 0 1000px rgb(255 255 255 / 90%);
        break-after: page;
        background: linear-gradient(
            -225deg,
            var(--frenchblue) 0%,
            var(--frenchblue) 33.3333%,
            var(--frenchwhite) 33.3333%,
            var(--frenchwhite) 66.6666%,
            var(--frenchred) 66.6666%,
            var(--frenchred) 100%
        );
    }
</style>


<div class="page {classes}">
    {#if title.length > 0}
        <h2>{title}</h2>
    {/if}
    <slot/>
</div>